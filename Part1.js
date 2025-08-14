import express from "express";
import { Product, Inventory } from "../models/index.js"; // just a example

const router = express.Router();

router.post("/api/products", async (req, res) => {
  try {
    const { name, sku, price, warehouse_id, initial_quantity } = req.body;

    if (
      !name ||
      !sku ||
      price == null ||
      !warehouse_id ||
      initial_quantity == null
    ) {
      return res.status(400).json({ error: "All fields are required" });
    }

    //allowing decimal Values
    const decimalprice = parseFloat(price);
    if (isNaN(decimalprice) || decimalprice <= 0) {
      return res.status(400).json({ message: "Invalid price" });
    }

    //for checking if sku is unique,
    // also, if taking mongo db as dataBase, we can say in the model file field that 'unique: true'
    const exist = await Product.findOne({ sku });
    if (exist) return res.status(400).json({ message: "sku must be unique." });

    const product = await Product.create({
      name,
      sku,
      decimalprice,
      warehouse_id,
    });

    //assumed that only initial_quantity can be null.
    //checking if initial_quantity is null and giving a default value
    const quantity = initial_quantity ?? 0;
    // Create inventory entry
    await Inventory.create({
      product_id: product.id,
      warehouse_id,
      quantity: quantity,
    });

    res.json({ message: "Product created", product_id: product.id });
  } catch (error) {
    console.error("Error creating product:", error);
    res.status(500).json({ error: "Failed to create product" });
  }
});

export default router;

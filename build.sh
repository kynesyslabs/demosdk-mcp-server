#!/bin/bash
cp .env.demosdk .env
npm install
npm run build
chmod +x dist/index.js

echo "Built successfully!"

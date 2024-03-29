require('dotenv').config();
const express = require('express');
// const {request} = require("express");
const app = express();
const port = 3000;
app.use(express.json());
const carsRouter = require('./routes/car_routes');
const driversRouter = require('./routes/driver_routes');
const healthRouter = require('./routes/health_routes');

app.use('/', carsRouter);
app.use('/', driversRouter);
app.use('/', healthRouter);

app.listen(port, () => {
    console.log(`Example app listening on port ${port}`);
});

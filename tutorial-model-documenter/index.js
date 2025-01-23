const { Sequelize } = require('sequelize');
const sequelize = require('./config/database');
const { db } = require('./db/models/index')
const fs = require("fs")

//const sequelize = new Sequelize('postgres://postgres:example@localhost:5432/chinhook-db')
console.log("ddfss")


var tables = []
// Loop through all models
for (const modelName in sequelize.models) {
  const model = sequelize.models[modelName];
  console.log(`Model Name: ${modelName}`);
  console.log(`Table Name: ${model.tableName}`);

  var table = {}
  var modelColumns = []

  table.TableName = model.tableName
  table.ModelName = model.name
  table.Orm = "sequelize"

  const attributes = model.getAttributes();

  
  for (const [attributeName, attributeDetails] of Object.entries(model.getAttributes())) {
    var column = {}
    column.ColumnName = attributeDetails.field
    column.PropertyName = attributeName
    column.IsPrimaryKey = attributeDetails.primaryKey
    column.IsNullable = attributeDetails.allowNull
    column.DatabaseType = attributeDetails.type.toSql()
    column.OrmType = attributeDetails.type.key
    column.IsAutoIncrement = attributeDetails.autoIncrement

    modelColumns.push(column)

  }
  table.Columns = modelColumns
  tables.push(table)


  console.log(''); // Add a blank line for better readability
}

// Write data in models.json
fs.writeFile('models.json', JSON.stringify(tables), (err) => {

  // In case of a error throw err.
  if (err) throw err;
})


console.log("Thankyou for playing with me.")

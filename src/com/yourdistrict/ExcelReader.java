package com.yourdistrict;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

public class ExcelReader 
{ 
	public void insertDataIntoTableFromFile(String fileLocation , String tableName) {
		FileInputStream file = null;
		XSSFWorkbook workbook = null;
		try 
		{ 
			DataManager dm = new DataManager();
					
			file = new FileInputStream(new File(fileLocation)); 

			//Create Workbook instance holding reference to .xlsx file 
			workbook = new XSSFWorkbook(file); 

			//Get first/desired sheet from the workbook 
			XSSFSheet sheet = workbook.getSheetAt(0); 

			String sql = "INSERT INTO " + tableName ;
			//Iterate through each rows one by one
			Iterator<Row> rowIterator = sheet.iterator(); 
			List<String> rowSQLs = new ArrayList();

			boolean isFirstRow = true;
			int lastRowNum = sheet.getLastRowNum();
			System.out.println(lastRowNum);
			for(int rowNUm = 0; rowNUm < lastRowNum ; rowNUm++) {
				
				System.out.println(rowNUm);
				Row row = sheet.getRow(rowNUm); 
				if(row.getCell(0) == null) {
					break;
				}
				short minColIx = row.getFirstCellNum();
				short maxColIx = row.getLastCellNum();
			
				String nextSql =  " (";
				for(short colIx=minColIx; colIx<maxColIx; colIx++) {
					
					Cell cell = row.getCell(colIx);
					if(cell == null) {
						break;
					}
					String cellValue = null;
					int cellType = cell.getCellType();
					
					if(cellType == Cell.CELL_TYPE_STRING) {
						cellValue = cell.getStringCellValue();
						if(!isFirstRow) {
							nextSql += "'";
						}
						
						nextSql += cellValue;  
						
						if(!isFirstRow) {
							nextSql += "'";
						}
						
						if(colIx+1 < maxColIx) {
							nextSql += ",";
						}
					}
				}
				nextSql += ")";
				rowSQLs.add(nextSql);
				isFirstRow = false;
			} 
			
			for(int i= 0 ; i < rowSQLs.size() ; i++) {
				String rowSQL = rowSQLs.get(i);
				sql += rowSQL; 
				if(i==0) {
					sql += " VALUES ";
				} else {
					if(i+1 < rowSQLs.size()) {
						sql += ",";
					}
				}
			}
			
			System.out.println("SQL : " + sql);
			Statement stmt = dm.getDBConnection().createStatement();
			stmt.executeUpdate(sql);
			
		} catch (Exception e) { 
			e.printStackTrace(); 
		} finally {
			try {
				file.close();
				workbook.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
} 
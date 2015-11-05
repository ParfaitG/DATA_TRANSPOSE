
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.HashSet;
import java.util.Set;

import java.util.Date;
import java.util.Calendar;
import java.text.SimpleDateFormat;
import java.text.ParseException;

import java.io.File;
import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;

class DoodlesObj {
    String datefld;
    int yearfld;
    int monthfld;
    int dayfld;
    String doodlefld;
  
    public DoodlesObj(String datefld, int yearfld, int monthfld, int dayfld, String doodlefld) {	  
	    this.datefld = datefld;
	    this.yearfld = yearfld;
	    this.monthfld = monthfld;
	    this.dayfld = dayfld;
	    this.doodlefld = doodlefld;	
    }
  
}

public class Transpose_Java {          
   
    public static void main(String[] args) {
	
	    String currentDir = new File("").getAbsolutePath();
        
            String doodledatestr = null;
            ArrayList<String> doodledates;
            doodledates = new ArrayList<String>();
	    
	    ArrayList<String> doodlemonths;
            doodlemonths = new ArrayList<String>();
	    
	    ArrayList<String> doodleyears;
            doodleyears = new ArrayList<String>();
	    
	    ArrayList<String> doodledays;
            doodledays = new ArrayList<String>();
            
            String doodlenamestr = null;
            ArrayList<String> doodlenames;
            doodlenames = new ArrayList<String>();
	    
	    SimpleDateFormat formatter = new SimpleDateFormat("MM/dd/yyyy");	    
	    Calendar cal = Calendar.getInstance();
	    
	    String jandata = null; String febdata = null; String mardata = null; String aprdata = null;
	    String maydata = null; String jundata = null; String juldata = null; String augdata = null;
	    String sepdata = null; String octdata = null; String novdata = null; String decdata = null;
		
	    // Build our list of objects
	    ArrayList<DoodlesObj> doodlelist = new ArrayList<DoodlesObj>();
	    ArrayList<TransposeObj> transposelist = new ArrayList<TransposeObj>();
		
            try {
		ArrayList gcsvfiles = new ArrayList<String>(Arrays.asList("GoogleDoodles2010.csv", "GoogleDoodles2011.csv", "GoogleDoodles2012.csv",
								          "GoogleDoodles2013.csv", "GoogleDoodles2014.csv", "GoogleDoodles2015.csv"));
		
		for (int i = 0; i < gcsvfiles.size(); i++)  {
		    String csv = currentDir + "\\Data\\" + gcsvfiles.get(i).toString();
		    BufferedReader br = null;
		    String line = "";
		    String cvsSplitBy = ",";
				
		    br = new BufferedReader(new FileReader(csv));		    		    
		    
		    int j = 0;
		    while ((line = br.readLine()) != null) {
			    // Skip column headers
			    if (j==0){				
				j++;
				continue;
			    }			    

			    // Use comma as separator
			    String[] gdata = line.split(cvsSplitBy);			    
			    
			    // First column
			    doodledatestr = gdata[0];			    
			    if(!doodledates.contains(doodledatestr)){
				doodledates.add(doodledatestr);
			    } else {
				continue;
			    }
			    
			    // Second column
			    doodlenamestr = gdata[1];
			    			    
   			    Date ddate = formatter.parse(gdata[0]);
	    		    cal.setTime(ddate);
			    
			    int dyear = cal.get(Calendar.YEAR);
			    int dmonth = cal.get(Calendar.MONTH)+1;
			    int ddays = cal.get(Calendar.DAY_OF_MONTH);
			    
			    doodlelist.add(new DoodlesObj(doodledatestr, dyear, dmonth, ddays, doodlenamestr));
			    
			    j++;
		    }
		}
				
		int y; int d;
		int row = 1;
		FileWriter writer = new FileWriter(currentDir + "\\DoodlesTransposedJava.csv");
		writer.append("Year,Day,January,February,March,April,May,June,July,August,September,October,November,December\n");
		
		for (y = 2010; y <=2015; y++) {	
		    for(d = 1; d <= 31; d++){
			jandata = ""; febdata = ""; mardata = ""; aprdata = ""; maydata = ""; jundata = "";
			juldata = ""; augdata = ""; sepdata = ""; octdata = ""; novdata = ""; decdata = "";
			for(DoodlesObj e : doodlelist) {
				
			    if (e.yearfld == y & e.dayfld == d) {
				
				if (e.monthfld == 1) {				   
				   jandata = "\"" + e.doodlefld + "\"";
				}
				
				if (e.monthfld == 2){				    
				    febdata = "\"" + e.doodlefld + "\"";
				}
			    
				if (e.monthfld == 3){
				   mardata = "\"" + e.doodlefld + "\"";
				}
			    
				if (e.monthfld == 4){
				   aprdata = "\"" + e.doodlefld + "\"";
				}
			    
				if (e.monthfld == 5){
				   maydata = "\"" + e.doodlefld + "\"";
				}
			    
				if (e.monthfld == 6){
				   jundata = "\"" + e.doodlefld + "\"";
				}
			    
				if (e.monthfld == 7){
				   juldata = "\"" + e.doodlefld + "\"";
				}
			    
				if (e.monthfld == 8){
				   augdata = "\"" + e.doodlefld + "\"";
				}
				
				if (e.monthfld == 9){
				   sepdata = "\"" + e.doodlefld + "\"";
				}
			    
				if (e.monthfld == 10){
				   octdata = "\"" + e.doodlefld + "\"";
				}
			    
				if (e.monthfld == 11){
				   novdata = "\"" + e.doodlefld + "\"";
				}
			    
				if (e.monthfld == 12){
				   decdata = "\"" + e.doodlefld + "\"";
				}								
			    }						
		       }		       
			writer.append(y  + "," + d + "," + jandata + "," + febdata + "," + mardata + "," + aprdata + "," + maydata + "," +
				      jundata + "," + juldata + "," + augdata + "," + sepdata + "," + octdata + "," + novdata + "," + decdata + "\n");
		    }
		      
		}		
		
		writer.flush();
		writer.close();
                System.out.println("Successfully tranposed data from long to wide format!");
		
	    } catch (FileNotFoundException ffe) {
                System.out.println(ffe.getMessage());
	    } catch (IOException ioe) {
                System.out.println(ioe.getMessage());
            } catch (ParseException pe) {
                System.out.println(pe.getMessage());
            }
	    
    }
}

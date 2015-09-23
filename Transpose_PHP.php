<?php

// Set current directory
$cd = dirname(__FILE__);

// Read CSV file
$csvFiles = Array('GoogleDoodles2010.csv', 'GoogleDoodles2011.csv', 'GoogleDoodles2012.csv',
                  'GoogleDoodles2013.csv', 'GoogleDoodles2014.csv', 'GoogleDoodles2015.csv');
$DoodlesData = [];

$row = 0;
foreach ($csvFiles as $csv) {
    $handle = fopen($cd.'/Data/'.$csv, "r");    
    
    while (($data = fgetcsv($handle, 1000, ",")) !== FALSE) {
        
        if ($data[0] == 'DoodleDate') { continue; }
 
        // OBTAIN VALUES
        $DoodlesData[$row][0] = date('Y-m-d', strtotime($data[0]));
        $DoodlesData[$row][1] = $data[1];
        $DoodlesData[$row][2] = date('Y', strtotime($data[0]));
        $DoodlesData[$row][3] = date('M', strtotime($data[0]));
        $DoodlesData[$row][4] = date('d', strtotime($data[0]));
        
        $row++;
    }
}

// Returning distinct days
$distinctdays = [];
foreach ($DoodlesData as $d) {
    $distinctdays[] = $d[0];
}
$distinctdays = array_unique($distinctdays, SORT_REGULAR);

foreach ($distinctdays as $c){    
    $distinctkeys[] = array_search($c, $DoodlesData, true);
}
$DoodlesDeDuped = array_intersect_key($DoodlesData, $distinctdays);

// Sort by dates
function datesort($a, $b) {
    $d1 = strtotime($a[0]);
    $d2 = strtotime($b[0]);    
    return $d1 - $d2;
}
usort($DoodlesDeDuped, 'datesort');

// Transpose data
$row = 0;
$DoodlesTransposed = [];
$years = array("2010", "2011", "2012", "2013", "2014", "2015");

for ($days=1; $days <= 31; $days++){
    foreach ($years as $y){                       
        $DoodlesTransposed[$row][0] = "";
        $DoodlesTransposed[$row][1] = "";                
        $DoodlesTransposed[$row][2] = ""; 
        $DoodlesTransposed[$row][3] = "";  
        $DoodlesTransposed[$row][4] = "";  
        $DoodlesTransposed[$row][5] = "";  
        $DoodlesTransposed[$row][6] = "";  
        $DoodlesTransposed[$row][7] = "";  
        $DoodlesTransposed[$row][8] = "";  
        $DoodlesTransposed[$row][9] = "";  
        $DoodlesTransposed[$row][10] = "";  
        $DoodlesTransposed[$row][11] = "";  
        $DoodlesTransposed[$row][12] = "";  
        $DoodlesTransposed[$row][13] = "";                    
        $row++;
    }    
}

$row = 0;
for ($days=1; $days <= 31; $days++){
    foreach ($years as $y){    
        foreach ($DoodlesDeDuped as $t) {            
            if ($t[2]==$y & $t[4] == $days) {
                $DoodlesTransposed[$row][0] = $t[2];
                $DoodlesTransposed[$row][1] = $t[4];                
                if ($t[3] == "Jan") { $DoodlesTransposed[$row][2] = $t[1]; } 
                if ($t[3] == "Feb") { $DoodlesTransposed[$row][3] = $t[1]; } 
                if ($t[3] == "Mar") { $DoodlesTransposed[$row][4] = $t[1]; } 
                if ($t[3] == "Apr") { $DoodlesTransposed[$row][5] = $t[1]; } 
                if ($t[3] == "May") { $DoodlesTransposed[$row][6] = $t[1]; } 
                if ($t[3] == "Jun") { $DoodlesTransposed[$row][7] = $t[1]; } 
                if ($t[3] == "Jul") { $DoodlesTransposed[$row][8] = $t[1]; } 
                if ($t[3] == "Aug") { $DoodlesTransposed[$row][9] = $t[1]; } 
                if ($t[3] == "Sep") { $DoodlesTransposed[$row][10] = $t[1]; } 
                if ($t[3] == "Oct") { $DoodlesTransposed[$row][11] = $t[1]; } 
                if ($t[3] == "Nov") { $DoodlesTransposed[$row][12] = $t[1]; } 
                if ($t[3] == "Dec") { $DoodlesTransposed[$row][13] = $t[1]; } 
            }            
        }
        $row++;
    }    
}

// Sort dates
foreach ($DoodlesTransposed as $key => $row) {
    $year_sort[$key] = $row[0];
    $day_sort[$key] = $row[1];
}
array_multisort($year_sort, SORT_ASC, $day_sort, SORT_ASC, $DoodlesTransposed);

// Output to CSV
$fp = fopen($cd.'/DoodlesTransposedPHP.csv', 'w');

fputcsv($fp, array('Year', 'Day', 'January', 'February', 'March', 'April', 'May', 'June',
              'July', 'August', 'September', 'October', 'November', 'December'));

foreach ($DoodlesTransposed as $fields) {    
    fputcsv($fp, $fields);

}
fclose($fp);

echo "Successfully outputted CSV file!";

?>
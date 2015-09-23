%Let fpath = C:\Path\To\Work\Directory;

** READING IN CSV FILES;
proc import	datafile = "&fpath\Data\GoogleDoodles2010.csv"
	out = Doodles2010 dbms = csv;
run;

proc import	datafile = "&fpath\Data\GoogleDoodles2011.csv"
	out = Doodles2011 dbms = csv;
run;

proc import	datafile = "&fpath\Data\GoogleDoodles2012.csv"
	out = Doodles2012 dbms = csv;
run;

proc import	datafile = "&fpath\Data\GoogleDoodles2013.csv"
	out = Doodles2013 dbms = csv;
run;

proc import	datafile = "&fpath\Data\GoogleDoodles2014.csv"
	out = Doodles2014 dbms = csv;
run;

proc import	datafile = "&fpath\Data\GoogleDoodles2015.csv"
	out = Doodles2015 dbms = csv;
run;

data DoodlesAll;
	set Doodles2010 Doodles2011 Doodles2012
        Doodles2013 Doodles2014 Doodles2015;
run;

** STRUCTURING DATA SET;
proc sort data=DoodlesAll out=DoodlesAll;
	by DoodleDate;
run;

data DoodlesAll (sortedby=DoodleDate);
	set DoodlesAll;
	Year = Year(DoodleDate);		
	Month = Month(DoodleDate);	
	Day = Day(DoodleDate);	
run;

data DoodlesAll (sortedby=DoodleDate);
	set DoodlesAll;
	by Year Month Day;
	if first.day;
run;

** TRANSPOSING DATA SET;
proc sort data=DoodlesAll out=DoodlesAll;
	by Year Day;
run;

proc transpose data=DoodlesAll out=DoodlesTransposed(drop=_name_) prefix=Month;
	by Year Day;			
	var Doodle;	
	id Month;
run;

data DoodlesTransposed;
  retain Year Day Month1 Month2 Month3 Month4 Month5 Month6 
                  Month7 Month8 Month9 Month10 Month11 Month11;
  set DoodlesTransposed;
  rename Month1 = January Month2 = February Month3 = March Month4 = April Month5 = May Month6 = June
         Month7 = July Month8 = August Month9 = September Month10 = October Month11 = November Month12=December; 
run;

** EXPORT DATASET TO CSV FILE;
proc export 
	data = Work.DoodlesTransposed
	outfile = "&fpath\DoodlesTransposedSAS.csv"
	dbms = csv replace;
run;

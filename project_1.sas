/*Importing the CSV file into SAS - I struggled doing it the other way*/
/*proc import datafile="C:\Users\kmand\Documents\ASU\LastSemester\STP315\Project_1\basketball.csv"*/
/*	out=work.basketball*/
/*	dbms=csv*/
/*	replace;*/
/*	getnames=yes;*/
/*run;*/


/*Author had some free time, and was interested in trends over time in the scores of games, as
well as how individual schools have fared over the years.*/

/*Proc Contents - Allows you to see what's involved*/
proc contents data=work.basketball; run;

/*Data step - I figured it out, ignore the above*/
data work.basketball;
	length Winning_School Losing_School Winner $25.;
	infile "C:\Users\kmand\Documents\ASU\LastSemester\STP315\Project_1\basketball.csv"
	dlm = "," missover dsd firstobs=2; /*First ob is 2, because it shows nothing at 1*/
		input Year Winning_School $ Winning_Score Losing_School $ Losing_Score;
		/*Adding variables*/
		PointLead=Winning_Score-Losing_Score;
		/*Name of school that won - if statement*/
		if PointLead>=1 then Winner=Winning_School;
			else if PointLead<=0 then Winner="Draw";
				else Losing_Score=Losing_School;
			/*The proc print output*/
			proc print data=work.basketball noobs label; 
				title "Basketball's School Winners";
					label
						Winning_School="Winning School"
						Winning_Score="Winning Score"
						Losing_School="Losing School"
						Losing_Score="Losing Score"
						PointLead="Point Lead";
run;
/*Proc Sort*/
proc sort data=work.basketball out=basketballsorted;
	by year;
run;
/*Proc Freq*/
proc freq data=basketballsorted order=freq;
	tables Winner PointLead;
run;
/*Proc means*/
proc means data=basketballsorted;
	var PointLead;
	class Year Winner;
run;
proc univariate data=work.basketball; 
	var PointLead;
run;



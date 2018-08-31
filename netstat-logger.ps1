#written/updated by Tony Jobson with the help of Ben Thompson UK to track the connection count in each state and log them to CSV to help spot port exhaustion issues.
#used in ticket:180827-01142

$dateFN = get-date -format yyyyMMdd_HH-mm-ss;
$hostname = $env:computername 


add-content ./NETSTAT_LOG_$hostname""_$dateFN.csv "Date,Time,TIME_WAIT,ESTABLISHED,CLOSE_WAIT,";

[int]$desired = Read-Host -Prompt 'How many loops to run? ( -1 for infinite )'

[int]$i = 0;



#write-host $desired;

while ($i -ne $desired )
     {
       # $date = get-date -format yyyyMMdd_HH-mm-ss;
       #legacy $date = get-date -format dd/MM/yyyy_HH:mm:ss
       $date = get-date -format dd/MM/yyyy
       $time = get-date -format HH:mm:ss


        $timewait = netstat -ano | findstr "TIME_WAIT" | Measure-Object;
        $established = netstat -ano | findstr "ESTABLISHED" | Measure-Object;
        $closewait = netstat -ano | findstr "CLOSE_WAIT" | Measure-Object;

        write-host "`r`n`r`n Date/Time = $date $time `r`n TIME_WAIT = " ($timewait).Count "`r`n ESTABLISHED =" ($established).Count "`r`n CLOSE_WAIT =" ($closewait).Count "`r`n`r`n"; 

        $timewaitC = ($timewait).Count
        $establishedC = ($established).Count
        $closewaitC = ($closewait).Count


        add-content ./NETSTAT_LOG_$hostname""_$dateFN.csv "$date,$time,$timewaitC,$establishedC,$closewaitC,";
        
        #we have more itterations to preform so let's put a short sleep in. this prevents a delay on a single instance run.
        if ($desired -lt 1) {start-sleep -s 5 ;} #to catch itterations from 2 to infinity.
        if ($desired - $i -gt 1){start-sleep -s 5;} # to ensure we wait 5 seconds between loops when we have a negative itteration entered.
        
        #allows infinate loop when desired is set to zero by the user. (loop logic kept failing with typical comparitors.
        if ($desired -gt 0 ) {$i++;} 
    }
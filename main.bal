import ballerina/time;
import ballerina/io;

public function main() {
    // Get current UTC time
    time:Utc currentUtc = time:utcNow();
    
    // Extract seconds from epoch (first element of the tuple)
    int epochSeconds = currentUtc[0];
    
    // Calculate days since epoch
    int daysSinceEpoch = epochSeconds / 86400; // 86400 seconds in a day
    
    // Unix epoch started on January 1, 1970 (day 0)
    // Simple calculation to get approximate date
    int year = 1970;
    int remainingDays = daysSinceEpoch;
    
    // Approximate year calculation (accounting for leap years roughly)
    while (remainingDays >= 365) {
        if (isLeapYear(year)) {
            if (remainingDays >= 366) {
                remainingDays -= 366;
                year += 1;
            } else {
                break;
            }
        } else {
            remainingDays -= 365;
            year += 1;
        }
    }
    
    // Simple month and day calculation
    int[] daysInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    if (isLeapYear(year)) {
        daysInMonth[1] = 29; // February has 29 days in leap year
    }
    
    int month = 1;
    int day = remainingDays + 1;
    
    while (day > daysInMonth[month - 1]) {
        day -= daysInMonth[month - 1];
        month += 1;
        if (month > 12) {
            month = 1;
            year += 1;
        }
    }
    
    io:println(string `Current date: ${year}-${month < 10 ? "0" : ""}${month}-${day < 10 ? "0" : ""}${day}`);
}

function isLeapYear(int year) returns boolean {
    return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
}
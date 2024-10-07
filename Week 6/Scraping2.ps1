. (Join-Path $PSScriptRoot "scraping.ps1")

$scraped_page = Invoke-WebRequest -TimeoutSec 10 http://10.0.17.30/tobescraped.html

$scraped_page.Count

$scrape_page.Links

$scraped_page.Links | select outerText, href

$h2s=$scraped_page.ParsedHtml.body.getElementsByTagName("h2") | select outerText

$h2s

$divs1=$scraped_page.ParsedHtml.body.getElementsByTagName("div") | where {

$_.getAttributeNode("class").Value -ilike "div-1"} | select innerText

$divs1

$FullTable = daysTranslator(gatherClasses)

$FullTable | Select-Object "Class Code", Instructor, Location, Days, "Time Start", "Time End" | Where-Object { $_.Instructor -ilike "Furkan Paligu" }

$FullTable | Where-Object { ($_.Location -ilike "JOYC 310") -and ($_.Days -contains "Monday") } | Sort-Object -Property "Time Start" | Select-Object "Time Start", "Time End", "Class Code"

$FullTable

$ITSInstructors = $FullTable | Where { ($_."Class Code" -like "SYS*") -or
                                       ($_."Class Code" -like "NET*") -or
                                       ($_."Class Code" -like "SEC*" ) -or
                                       ($_."Class Code" -like "FOR*" ) -or
                                       ($_."Class Code" -like "CIS*" ) -or
                                       ($_."Class Code" -like "DAT*") } `
                             | Select "Instructor" | Sort-Object "Instructor" -Unique
$ITSInstructors

$FullTable | Where { $_.Instructor -in $ITSInstructors.Instructor } `
           | Group "Instructor" | Select-Object Count, Name | Sort-Object Count -Descending


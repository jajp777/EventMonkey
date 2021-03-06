SELECT
winevent.written_time AS "Time",
winevent.event_identifier AS "EventID",
winevent.we_description AS "Description",
CASE 
  WHEN event_identifier == 4624 
    THEN json_extract(we_jrec,'$.EventData.Data[5].#text')
  WHEN event_identifier == 4634 
    THEN json_extract(we_jrec,'$.EventData.Data[1].#text')
  WHEN event_identifier == 4648 
    THEN json_extract(we_jrec,'$.EventData.Data[5].#text') || ' -> ' || 
	json_extract(we_jrec,'$.EventData.Data[1].#text')
  ELSE '<Not Handled>'
  END AS "LogonID",
winevent.computer_name AS "Computer",
/*winevent.xml_string AS "XML",*/
winevent.source_name AS "Channel",
winevent.we_source AS "Source"
FROM "winevent"
WHERE
Channel == 'Microsoft-Windows-Security-Auditing' AND
event_identifier IN (4624,4625,4634,4648)
ORDER BY written_time
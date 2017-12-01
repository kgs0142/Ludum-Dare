///@description Load json file, and return the map structure.
///@param Json file name.

var fileName = argument[0];

var parsedData = ds_map_create();
if (file_exists(fileName) == false)
{
	return parsedData;
}

var strData = "";
var jsonFile = file_text_open_read(fileName);
while (!file_text_eof(jsonFile))
{
	strData += file_text_read_string(jsonFile);
	file_text_readln(jsonFile);
}
file_text_close(jsonFile);

parsedData = json_decode(strData);
return parsedData;

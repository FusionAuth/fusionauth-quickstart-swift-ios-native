import json

# Load the SARIF file
with open('/Users/escii/Documents/GitHub/fusionauth-ios-mobilesdk-test-app/output.sarif.json', 'r') as file:
    sarif_data = json.load(file)

# Function to remove leading slash from a URI
def remove_leading_slash(uri):
    if uri.startswith('/'):
        return uri[1:]
    return uri

# Function to convert string to integer if possible
def convert_to_int(value):
    try:
        return int(value)
    except ValueError:
        return value

# Iterate through the results and update the URIs and convert columns and lines to integers
for run in sarif_data['runs']:
    for result in run['results']:
        for location in result['locations']:
            uri = location['physicalLocation']['artifactLocation']['uri']
            location['physicalLocation']['artifactLocation']['uri'] = remove_leading_slash(uri)
            
            region = location['physicalLocation']['region']
            if 'startColumn' in region:
                region['startColumn'] = convert_to_int(region['startColumn'])
            if 'startLine' in region:
                region['startLine'] = convert_to_int(region['startLine'])

# Save the updated SARIF file
with open('/Users/escii/Documents/GitHub/fusionauth-ios-mobilesdk-test-app/output_fixed.sarif.json', 'w') as file:
    json.dump(sarif_data, file, indent=2)

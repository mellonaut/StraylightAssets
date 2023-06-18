# Get the web app names containing "straylight" in the "StraylightBlog" resource group
webapp_names=$(az webapp list --resource-group StraylightBlog --query "[?contains(name, 'straylight')].name" -o tsv)

# Check if any matching web app names were found
if [ -z "$webapp_names" ]; then
    echo "No web apps matching 'straylight' found in the StraylightBlog resource group."
    exit 1
fi

# Select the first matching web app
selected_webapp_name=$(echo "$webapp_names" | awk 'NR==1{print $1}')

# Establish an SSH connection to the selected web app
az webapp ssh --resource-group StraylightBlog --name "$selected_webapp_name"

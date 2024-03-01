#!/bin/bash                          
# Define color codes                 RED='\033[0;31m'
GREEN='\033[0;32m'                   CYAN='\033[0;36m'                    NC='\033[0m' # No Color
                                     # Display a welcome message in green echo -e "${GREEN}Welcome to the Question Generator!${NC}"                                                      # Prompt the user for input                    echo -e "${CYAN}Please enter your question:${NC}"               read -p "$(echo -e ${CYAN}Please enter your question:${NC})" user_question                                                                            # Validate user input
if [ -z "$user_question" ]; then     
    echo -e "${RED}Error: You must enter a question.${NC}"
    exit 1
fi

# Display a message indicating the question is being processed
echo -e "${CYAN}Generating content...${NC}"

# Prepare the data for the API request
data='{"contents":[{"parts":[{"text":"'"$user_question"'"}]}]}'

# Send the request using curl        
response=$(curl -s \
-H 'Content-Type: application/json' \
-d "$data" \
-X POST "https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=AIzaSyAC62qfFgaXALUY_f9_orIt4N8lh7lg0uE")

# Check for errors
if [ $? -ne 0 ]; then
    echo -e "${RED}Error: Failed to generate content.${NC}"
    exit 1
fi

# Display a completion message in green
echo -e "${GREEN}Content generated successfully.${NC}"

# Display the response from the API
echo -e "Response:\n"
echo "$response" | jq '.candidates[0].content.parts[0].text' -r

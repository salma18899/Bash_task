## Function takes a message as parameter , and print it as an error
function PrintErrorMsg {
        Msg=${1}
        echo "ERROR: ${Msg}"
        return 0

}
function PrintMainMenu {

        echo "Main menu"
        echo -e "\t a) Authenticate"
        echo -e "\t 1) Add a customer"
        echo -e "\t 2) Update a customer email"
        echo -e "\t 3) Delete a customer"
        echo -e "\t 4) Query a customer email"
        echo -e "\t 5) Quit"
        echo -n "Please, select an option: "
}
function PrintDetails {

        while read FLINE
        do
                CustomerID=$( echo "${FLINE}" | awk 'BEGIN {FS=":"} {print $1}')
                CustomerName=$( echo "${FLINE}" | awk 'BEGIN {FS=":"} {print $2}')
                CustomerEmail=$( echo "${FLINE}" | awk 'BEGIN {FS=":"} {print $3}')
                echo  "The Customer ID : ${CustomerID} "
                echo  "The Customer Name : ${CustomerName}"
                echo  "The Email of this customer is ${CustomerEmail}"

        done < details.db
}

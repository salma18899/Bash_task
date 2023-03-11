function queryCustomer {
        local CUSTNAME=${1}
        LINE=$(grep "^{CUSTNAME}$" customers.db)
        [ -z ${LINE} ] && PrintErrorMsg "Sorry ${CUSTNAME} is not found" && return 7
        echo "Information for the customer"
        echo -e "\t ${LINE}"
        return 0

}

function UpdateEmail {
        mail="${1}"
        ID=${2}
        check=1
while read FLINE

do
        if [ check==1 ]
        then
        COL1=$(echo ${FLINE} | awk 'BEGIN{FS=":"}{ print $1}')
        col3=$(echo ${FLINE} | awk 'BEGIN{FS=":"}{ print $3}')
       if [ ${COL1} == ${ID} ]
              ## &&  [ "${col3}" == "${mail}" ]
       then
           check=0
        sed -i "s/${col3}/${mail}/g" customers.db
           return 1
       fi
       fi
        #then
    # return 1
   #else
  # return 0
   done < customers.db
 #      [ ${COL1} -eq ${ID} ] && return 1
return 0
}
function DeleteUser {
        user="${1}"
        check=1
while read FLINE
do
        if [ check==1 ]
        then
       COL1=$(echo ${FLINE} | awk 'BEGIN{FS=":"}{ print $1}')
       if [ ${COL1} == ${ID} ]
              ## &&  [ "${col3}" == "${mail}" ]
       then
           check=0
        sed -i "/${COL1}/d" customers.db
           return 1
       fi
       fi
        #then
    # return 1
   #else
  # return 0
   done < customers.db
 #      [ ${COL1} -eq ${ID} ] && return 1
return 0
}

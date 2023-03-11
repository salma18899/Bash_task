## Function Takes a Parameters which is file name and return 0 if the file exists
function CheckFile {

FileName=${1}
 [ ! -f ${FileName} ] && return 1
        return 0
}
## Function Takes a Parameters which is file name and return 0 if the file has read perm

function CheckFileR {
FileName=${1}
[ ! -r ${FileName} ] && return 1
        return 0
}
## Function Takes a Parameters which is file name and return 0 if the file has write perm

function CheckFileW {
FileName=${1}
[ ! -w ${FileName} ] && return 1
        return 0

}

## Function Takes a Parameter with username and return 0 if the user requested is the same as cuurent user

 function CheckUser {
        RUSER=${1}
        [ ${RUSER} == ${USER} ] && return 0
        return 1


 }
###### Function takes a username, and password then check them in accs.db, and returns 0 if match otherwise returns 1
function authUser {
        USERNAME=${1}
        USERPASS=${2}
 ###1-Get the password hash from accs.db for this user if user found
        ###2-Extract the salt key from the hash
        ###3-Generate the hash for the userpass against the salt key
        ###4-Compare hash calculated, and hash comes from the file.
        ###5-IF match returns 0,otherwise returns 1
        USERLINE=$(grep ":${USERNAME}:" accs.db)
        [ -z ${USERLINE} ] && return 0
        PASSHASH=$(echo ${USERLINE} | awk ' BEGIN { FS=":" } { print $3} ')
        SALTKEY=$(echo ${PASSHASH} | awk ' BEGIN { FS="$" } { print $3 } ')
        NEWHASH=$(openssl passwd -salt ${SALTKEY} -6 ${USERPASS})
        if [ "${PASSHASH}" == "${NEWHASH}" ]
        then
        USERID=$(echo ${USERLINE} | awk ' BEGIN { FS=":" } { print $1} ')
                return ${USERID}
        else
                return 0
        fi



}
###Function to check for invalid option
function checkInt {
NU=${1}
VI=$(echo ${NU} | grep -c '^[0-9]*$')
[ ${VI} -eq 0 ] && return 0
return 1


}
function CheckIdEX {
        ID=${1}
        check=1
while read FLINE

do
      if [ check==1 ]
        then
        COL1=$(echo ${FLINE} | awk 'BEGIN{FS=":"}{ print $1}')
        [ ${COL1} -eq ${ID} ]
         [ ${?} -eq 0 ] && echo "${FLINE}" > details.db  && check=0 && return 1
        fi
        #then
    # return 1
   #else
  # return 0
   done < customers.db
 #      [ ${COL1} -eq ${ID} ] && return 1 
return 0
}
function checkName {
NA=${1}
VN=$(echo ${NA} | grep -c '^[[:alpha:]]*$')
[ ${VN} -eq 0 ] && return 0
return 1
}
function checkMail {
EM="${1}"
#regex="^[a-z0-9!#\$%&'*+/=?^_\`{|}~-]+(\.[a-z0-9!#$%&'*+/=?^_\`{|}~-]+)*@([a-z0-9]([a-z0-9-]*[a-z0-9])?\.)+[a-z0-9]([a-z0-9-]*[a-z0-9])?\$"
#regex="^[A-Za-z0-9_%+-]+@[A-Za-z0-9-]+\.[A-Za-z]{2,4}$"
VEM=$(echo ${EM} | grep -c "[[:alnum:]]*@[[:alnum:]]*.[[:alnum:]]*")
if [ ${VEM} -eq 0 ]
then
        return 0
else
return 1
fi

}

function CheckMailEX {
        ID="${1}"
         check=1
while read FLINE

do
        if [ check==1 ]
        then
        COL3=$(echo ${FLINE} | awk 'BEGIN{FS=":"}{ print $3}')
       if [ "${COL3}" == "${ID}" ]
       then

           check=0
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


                                          



import sys
from enum import Enum

s = """[test]
# WARNING! Change default variable of jwt_secret. You should change it periodically
# It only affects to current authentication tokens, you can change safetely anytime
# When it changes user are just forced to log in again
jwt_secret: LwsURwmquwhWfpvvYPznjcIN
jwt_expire_minutes: 120"""


class LineType(Enum):
    COMMENT = 1
    TOPIC = 2
    VALUE = 3

if __name__ == '__main__':
    # command line ----

    if(len(sys.argv)) == 1:
        print("=== config_setter === \n"
              "config_setter [path_in] [path_out] [pattern]\n"
              "pattern: key1=value1 key1=value2 ...\n"
              "example: \"python ./config_setter file.conf name=test1 password=test2\"")
        exit()
    elif (len(sys.argv)) <= 2:
        print("invalid parameters")
        exit()

    sys_params = sys.argv[2:]

    path_in = sys.argv[1]
    #path_out = sys.argv[2]

    sys_param_list = []

    for i in sys_params:
        temp = i.split('=')
        sys_param_list.append([temp[0], temp[1]])


    # parse -----

    file_data = ""
    with open(path_in, 'r') as file:
        file_data = file.read()

    #print(file_data)

    t = file_data.split('\n')

    data = []

    for i in t:
        if not i:
            continue
        elif i.startswith('['):
            data.append([LineType.TOPIC, i])
            continue
        elif i.startswith('#'):
            data.append([LineType.COMMENT, i])
            continue
        else:
            temp = i.replace(' ', '')
            temp_list = temp.split(':')
            data.append([LineType.VALUE, temp_list[0], temp_list[1]])

    # set variables -----

    for i in data:
        if(i[0] != LineType.VALUE): continue
        for k in sys_param_list:
            if(i[1] == k[0]):
                i[2] = k[1]
                continue

    # output -----

    output = ""

    for i in data:
        if( (i[0] == LineType.TOPIC) or
                (i[0] == LineType.COMMENT) ):
            output += "\n" + i[1] + "\n" # "\n" "\n" +
            continue
        else:
            output += i[1] + ": " + i[2] + '\n'
            continue

    #print(output)
    with open(path_in, 'w') as file:
        file.write(output)

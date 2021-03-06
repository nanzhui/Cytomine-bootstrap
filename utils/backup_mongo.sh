#!/bin/bash

#
# Copyright (c) 2009-2018. Authors: see NOTICE file.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#made scripts in a util folder


if [ -z "$1" ]
then
	echo "No argument supplied. Data is saved in manBU folder"
	NAME="manBU"
else
	NAME=$1
fi

return=0
docker exec mongodb mongodump -h localhost -o /BU && message="Backup OK. " || (message="Backup failed. " && return=1)
docker cp mongodb:/BU $NAME && message=$message"Copy OK. " || (message=$message"Copy failed. " && return=1)
docker exec mongodb rm -rf /BU && message=$message"Deletion OK. " || (message=$message"Deletion failed. " && return=1)

if [ $return -gt 0 ]
  then
   echo "ERROR"
 else
   echo "Terminated"
fi



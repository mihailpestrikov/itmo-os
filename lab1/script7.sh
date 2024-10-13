#!/bin/bash

grep -ErohI '\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b' /etc > emails.lst


sc query > services.txt

net stop Everything
timeout /t 5

sc query > services_updated.txt

fc /c /w C:\LAB6\3\services_updated.txt C:\LAB6\3\services.txt > compared.txt

net start Everything
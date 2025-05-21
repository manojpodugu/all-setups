sudo yum install java-17-amazon-corretto -y
wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.99/bin/apache-tomcat-9.0.99.tar.gz
tar -zxvf apache-tomcat-9.0.99.tar.gz
mv apache-tomcat-9.0.99 tomcat
sed -i '56  a\<role rolename="manager-gui"/>' tomcat/conf/tomcat-users.xml
sed -i '57  a\<role rolename="manager-script"/>' tomcat/conf/tomcat-users.xml
sed -i '58  a\<user username="tomcat" password="raham123" roles="manager-gui, manager-script"/>' tomcat/conf/tomcat-users.xml
sed -i '59  a\</tomcat-users>' tomcat/conf/tomcat-users.xml
sed -i '56d' tomcat/conf/tomcat-users.xml
sed -i '21d' tomcat/webapps/manager/META-INF/context.xml
sed -i '22d'  tomcat/webapps/manager/META-INF/context.xml
sh tomcat/bin/startup.sh


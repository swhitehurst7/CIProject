$IP = '10.50.20.33:8080/aaron'

node 'Master.netbuilder.private'{
	include java
	include git
	include maven
	include jira
}
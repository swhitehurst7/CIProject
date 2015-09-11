$IP = '10.50.20.27:8080/aaron'

node 'Master.netbuilder.private'{
	include java
	include git
	include maven
#	include jira
#	include jenkins
	include nexus
}

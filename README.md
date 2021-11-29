# Brett_Benson_Cyber_knowledge
Sample configuration files and information that demonstrates Cybersecurity skills
## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

![alt text](https://github.com/BrettB76/Brett_Benson_Cyber_knowledge/blob/main/Diagrams/Cloud_network_with_ELK.png "Cloud Network with ELK")

These files have been tested and used to generate a live ELK deployment on Azure. The configuration files have been collated together into roles with the main YAML file creating the entire deployment pictured above.
Alternatively, individual roles may be used to install only certain pieces of the configuration, such as Filebeat.

Link to main YAML installation file: https://github.com/BrettB76/Brett_Benson_Cyber_knowledge/blob/main/Ansible/Full_VN_ELK_setup_yml.txt
![alt text](https://github.com/BrettB76/Brett_Benson_Cyber_knowledge/blob/main/Images/Full_VN_ELK_setup.png "Set up YML")

This document contains the following details:
- Description of the Topology
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly redundant, in addition to restricting access to the network.
Load balancers can defend an organisation against distributed denial-of-service (DDoS) attacks.
The primary advantages of using a Jump Box provisioner are automation which reduces the potential for human error and makes it easier to configure potentially thousands of identical machines.

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the data and system logs.
Filebeat monitors the log files or locations that you specify, collects log events, and forwards them either to Elasticsearch or Logstash for indexing.
Metricbeat helps you monitor your servers by collecting metrics from the system and services running on the server or container.

The configuration details of each machine may be found below.

| Name       | Function   | IP Address | Operating System |
|------------|------------|------------|------------------|
| Jump Box   | Gateway    | 10.0.0.4   | Linux            |
| Web-1      | Webserver  | 10.0.0.5   | Linux            |
| Web-2      | Webserver  | 10.0.0.6   | Linux            |
| Web-3      | Webserver  | 10.0.0.7   | Linux            |
| ELK_Server | Monitoring | 10.1.0.4   | Linux            |

### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the Jump Box machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses:
49.180.225.215

Machines within the network can only be accessed by SSH key pair as using a password is inherently weak.

The ELK VM is accessible via the Jump Box provisioner (IP 10.0.0.4) and my personal computer (IP 49.180.225.215) through port 5601 to utilise Kibana web application.

A summary of the access policies in place can be found in the table below.

| Name       | Publicaly Accessible | Allowed IP Address        |
|------------|----------------------|---------------------------|
| Jump Box   | Yes                  | 49.180.225.215            |
| Web-1      | No                   | 10.0.0.4                  |
| Web-2      | No                   | 10.0.0.4                  |
| Web-3      | No                   | 10.0.0.4                  |
| ELK_Server | Yes                  | 10.0.0.4 & 49.180.225.215 |

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because it acts as Infrastructure as Code (IaC).
The primary benefit to IaC is that everyone can see exactly how the network is configured by reading text files.

The playbook implements the following tasks:
- Install docker.io with apt (with update_cache: yes to ensure it loads correctly)
- Install python3-pip with apt
- Install docker with pip
- Increase system memory with command (to minimum 262144 to ensure the system works)
- Use more memory with sysctl
- Install ELK container with docker_container (enable published port pairs, 5601:5601, 9200:9200, 5044:5044)
- Enable docker server with systemd

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

![alt text](https://github.com/BrettB76/Brett_Benson_Cyber_knowledge/blob/main/Images/docker_ps_output.png "Docker output")

### Target Machines & Beats
This ELK server is configured to monitor the following machines:
10.0.0.5
10.0.0.6
10.0.0.7

We have installed the following Beats on these machines:
Filebeat and Metricbeat

These Beats allow us to collect the following information from each machine:
Filebest collects system logging service information with an example by SSH login attempts.
Metricbeat collects metrics from the Docker server with an example being CPU usage.

### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node (a Linux Server that has Ansible installed on it and is used for managing remote hosts or nodes).
Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Connect to ansible container through docker start and docker attach commands.
- Navigate to: /etc/anisble
- Ensure that the /etc/ansible/hosts file has all IP addresses listed and seperated into the correct host groups of elk and webservers for correct installation.
![alt text](https://github.com/BrettB76/Brett_Benson_Cyber_knowledge/blob/main/Images/hosts_configuration.png "Hosts configuration")
- Ensure that the /etc/ansible/roles/install-filebeat/files/filebeat-config.yml file has the correct IP address for ELK server (lines 1106 & 1806).
![alt text](https://github.com/BrettB76/Brett_Benson_Cyber_knowledge/blob/main/Images/Filebeat_config_1106.png "Filebeat 1106")
![alt text](https://github.com/BrettB76/Brett_Benson_Cyber_knowledge/blob/main/Images/Filebeat%20config_1806.png "Filebeat 1806")
- Ensure that the /etc/ansible/roles/install-metricbeat/files/metricbeat-config.yml file has the correct IP address for ELK server (line 62).
![alt text](https://github.com/BrettB76/Brett_Benson_Cyber_knowledge/blob/main/Images/Metricbeat_config.png "Metricbeat")
- Run the playbook with command: ansible-playbook Full_VN_ELK_setup.yml
- To check if the installationg has worked, access web browser
	Web servers: http://20.211.120.76/setup.php
	ELK server: http://52.243.88.131:5601/app/kibana#/home

![alt text](https://github.com/BrettB76/Brett_Benson_Cyber_knowledge/blob/main/Images/Web_servers_confirmed.png "Webservers")
![alt text](https://github.com/BrettB76/Brett_Benson_Cyber_knowledge/blob/main/Images/Kibana_confirmed.png "Kibana")

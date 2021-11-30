# Brett_Benson_Cyber_knowledge
Sample configuration files and information that demonstrates Cybersecurity skills

### ELK Configuration

Ansible was used to automate the configuration of the ELK machine. No configuration was performed manually, which is advantageous because it acts as Infrastructure as Code (IaC).
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
- 10.0.0.5
- 10.0.0.6
- 10.0.0.7

We have installed the following Beats on these machines:
- Filebeat
- Metricbeat

These Beats allow us to collect the following information from each machine:
- Filebest collects system logging service information with an example by SSH login attempts.
- Metricbeat collects metrics from the Docker server with an example being CPU usage.

### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node (a Linux Server that has Ansible installed on it and is used for managing remote hosts or nodes).

Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Connect to ansible container through docker start and docker attach commands.
- Navigate to: /etc/anisble
- Ensure that the /etc/ansible/hosts file has all IP addresses listed and seperated into the correct host groups of elk and webservers for correct installation.

![alt text](https://github.com/BrettB76/Brett_Benson_Cyber_knowledge/blob/main/Images/hosts_configuration.png "Hosts configuration")
- Ensure that the /etc/ansible/roles/install-filebeat/files/filebeat-config.yml file has the correct IP address for ELK server (lines 1106 & 1806).

![alt text](https://github.com/BrettB76/Brett_Benson_Cyber_knowledge/blob/main/Images/Filebeat_config_line_1106.png "Filebeat 1106")
![alt text](https://github.com/BrettB76/Brett_Benson_Cyber_knowledge/blob/main/Images/Filebeat%20config_line_1806.png "Filebeat 1806")
- Ensure that the /etc/ansible/roles/install-metricbeat/files/metricbeat-config.yml file has the correct IP address for ELK server (line 62).

![alt text](https://github.com/BrettB76/Brett_Benson_Cyber_knowledge/blob/main/Images/Metricbeat_config.png "Metricbeat")
- Run the playbook with command: `ansible-playbook Full_VN_ELK_setup.yml`
- To check if the installationg has worked, access web browser
  - Web servers: `http://20.211.120.76/setup.php`
  - ELK server: `http://52.243.88.131:5601/app/kibana#/home`

![alt text](https://github.com/BrettB76/Brett_Benson_Cyber_knowledge/blob/main/Images/Web_servers_confirmed.png "Webservers")
![alt text](https://github.com/BrettB76/Brett_Benson_Cyber_knowledge/blob/main/Images/Kibana_confirmed.png "Kibana")

### Investigations with Kibana.
In order to view and check log data in Kibana the following processes were run. 

- Generated high amount of failed SSH login attempts from the Jump Box provisioner using a nested loop script to test Filebeat.
  - Link to script: [ELK ssh failed loging test](https://github.com/BrettB76/Brett_Benson_Cyber_knowledge/blob/main/Linux/ELK_ssh_failed_login_test_script.sh)
  - Run the command: `./ELK_ssh_failed_login_test_script` and let it run for a few minutes.
  - Results are accessed through the Logs and Dashboard section of Kibana using SSH template and show both successful and failed logins.
  - Links to results
    - [Kibana - Dashboard with SSH](https://github.com/BrettB76/Brett_Benson_Cyber_knowledge/blob/main/Images/SSH_failed_login.pdf)
    - [Kibana - Logs for failed SSH logins](https://github.com/BrettB76/Brett_Benson_Cyber_knowledge/blob/main/Images/SSH_failed_login_logs.png)

- Run a Linux stress test from each individual web server to utlise Metricbeat.
  - SSH into each web server VM and run the below commands
  - Install stress package `sudo apt install stress`
  - Run stress for a few minutes `sudo stress --cpu 1`
  - Results show an increase in CPU usage.  This could be a cause of concern as overworked computers are at greater risk of failure.
  - Link to results
    - [Kibana - Increase CPU usage](https://github.com/BrettB76/Brett_Benson_Cyber_knowledge/blob/main/Images/Stress_increase_CPU_usage.png)

- Run a simulated DoS web attack using a nested loop script from the Jump Box provisioner.
  - Link to script: https://github.com/BrettB76/Brett_Benson_Cyber_knowledge/blob/main/Linux/ELK_wget_requests_test_script.sh
  - Run for a few minutes: command `./ELK_wget_requests_test_script`
  - Results show an increase in network traffic
  - Link to results
    - [Kibana - Increased network traffic](https://github.com/BrettB76/Brett_Benson_Cyber_knowledge/blob/main/Images/wget_network_traffic.png)

# BlockPI monitoring setup guide

1. Setup Grafana, Prometheus and node-exporter
2. Configure Prometheuss 
3. Configure Grafana
4. Create Klaytn Dashboard



# Setup Grafana, Prometheus and node-exporter

Grafana - platform for monitoring and data analysis visualization.

For Grafana installation and workspace, we need to install i Prometheus and node-exporter. 

### Start root
```
sudo su

```

### Update packages
```
sudo apt update && sudo apt upgrade -y

```
### Setup docker

```
sudo apt update
sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
sudo apt update
apt-cache policy docker-ce
sudo apt install docker-ce

```
### Install git

```
apt install git

```

### Download docker-compose.yml
```
cd ~
git clone https://github.com/cybernekit/Grafana-Prometheus.git
cd ~/Grafana-Prometheus

```
![Screenshot](https://user-images.githubusercontent.com/59205554/170821373-17d41ca2-0a57-4721-a64d-1dce8ee9f8a3.png)

### Create container
```
sudo docker swarm init
sudo docker stack deploy -c ~/Grafana-Prometheus/docker-compose.yml monitoring

```

![Screenshot](https://user-images.githubusercontent.com/102728347/179355943-5608a86a-2b56-4a56-b2f7-b31afaabc575.png)


### Check whether the containers have started
Do not rush to start, wait a while for it to start everything.

```
sudo docker ps

```
Check containers
![Screenshot](https://user-images.githubusercontent.com/59205554/170821748-022e38d8-d824-465a-8979-334cff2ca31f.png)


# Configure Prometheus
 Go to promtheus configuration. Find `promtheus.yml` and configure with your data.
```
cd /var/lib/docker/volumes/monitoring_prom-configs/_data
rm prometheus.yml
wget https://raw.githubusercontent.com/MaxMavaIll/BlockPI_monitoring/main/prometheus.yml

```

Change `your_address` with your data
```
sed -i 's/your_address/<Your_address>/' /var/lib/docker/volumes/monitoring_prom-configs/_data/prometheus.yml
```
### Restart Prometheus
For Prometeus restart we need to find container id
```
sudo docker ps

```
![Screenshot](https://user-images.githubusercontent.com/102728347/179354582-efc6efda-bd83-4a37-93c6-0f3a2b43e6e8.png)

```
sudo docker restart <CONTAINER ID>
```
Prometheus launched. 
Now to check whether it is in good condition, we enter in the browser.
```
http://<your_address_grafana>:9090
```
(Error -> If it displays that the page is not found, wait a little and try to enter your address and port again)

Enter Status -> Targets

![Screenshot](https://user-images.githubusercontent.com/102728347/179355096-409b3161-6675-43d9-b543-80b9ecafb370.jpeg)

If you have this view, then everything is connected and working correctly 

![Screenshot](https://user-images.githubusercontent.com/102728347/179355199-eed91018-6d6c-49bc-a3e3-463b04f64932.png)

# Grafana configuration

Start Google on your PC. 

Enter the address through a browser with a port `3000`:
```
http://<IP_address>:3000
```
We will see the following (Of course, if everything is installed correctly)

![Screenshot](https://user-images.githubusercontent.com/102728347/179351515-3004bcf9-edff-4445-8658-416eadf7e41d.jpeg)

By default user -> `admin`; password -> `admin`.
Next, you will be prompted to set your password, Grafana will save it in the database and from the next time you will need to enter this data to access your Grafana.
Enter to Grafana -> ![Screenshot from 2022-07-16 16-27-06](https://user-images.githubusercontent.com/102728347/179356902-73f0009d-36bd-49f7-b012-3516869bebdd.png) 

add data source -> ![Screenshot](https://user-images.githubusercontent.com/102728347/179356942-de8fa026-0365-43a6-9a3f-6d52c37d9450.png)

Prometheus
![Screenshot](https://user-images.githubusercontent.com/102728347/179357543-57fea3cc-e144-47c3-878a-d5f11790accf.png)

 Add http://prometheus:9090 to the  url
Lets save thi options `save & test`

If you got a green checkmark with a name, it means everything was successful
`Data source is working`

# Configure Klaytn

Enter inport -> import

Here's what we'll see  
![Screenshot](https://user-images.githubusercontent.com/102728347/179358209-ecd023cf-1ca3-47f9-82b5-5c20b5ceb039.png)

Import BlockPI Dashboard 
Set `Import via panel json`

* [Klaytn](https://github.com/Vgk88/BlockPI-monitoring-guide/blob/main/Klaytn.json)

At the very beginning, you will get an error, but in order for everything to work, you need to go to `dashboard settings` -> `Variables`

![Screenshot](https://user-images.githubusercontent.com/102728347/179372068-436382f2-18b6-457d-be8a-7d39afc12751.jpeg)

![Screenshot](https://user-images.githubusercontent.com/102728347/179372230-96412459-f16d-4c85-bd81-8710e044e1c5.png)

Now we need to go into each of these options, fix `Data source` to prometheus and save `Update`

![Screenshot](https://user-images.githubusercontent.com/102728347/179372346-c3cde8c1-49b6-45d0-ac90-1a5e42a37f67.png)

Go to the main screen and press `Klaynt node status` -> `edit`, and then `Klaynt node height` -> `edit` and `klaytn use memory` -> `edit`
![Screenshot](https://user-images.githubusercontent.com/102728347/179372502-fec90a30-9cb4-4242-9016-0ff83a739dba.png)

Also select Prometheus and click `apply'
![Screenshot](https://user-images.githubusercontent.com/102728347/179372586-52b32e64-d397-4d31-8328-9d34fa1d3960.png)


# Congratulations, now you can scan your statiscics!!!



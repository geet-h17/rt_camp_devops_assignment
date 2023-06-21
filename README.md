
# The WordPress Dockerizer: A Tool for Creating and Managing WordPress Sites

This Bash script allows you to easily manage WordPress sites using Docker and Docker Compose. It provides commands for creating, starting, stopping, and deleting WordPress sites.




## Installation

Run my project on your system my clonning this repo...

```bash
  git clone https://github.com/geet-h17/rt_camp_devops_assignment
```
You also need to have Docker and Docker Compose setted up on your machine.

To Install Docker:

Visit the Docker website and follow the installation instructions for your operating system.

To Install Docker Compose:

Visit the Docker Compose documentation and follow the installation instructions for your operating system.

At last make this script executable before running it.
```bash
chmod u+x script.sh
```

## Features

Create a Site:

To create a new WordPress site, use the following command:

```bash
Copy code
./script.sh create <site_name>
```
Replace <site_name> with a name for your site (e.g., myblog). This will create a directory with the specified name and generate a Docker Compose file inside it to set up the WordPress environment.

Start a Site:

To start a previously created WordPress site, use the following command:

```bash
Copy code
./script.sh start <site_name>
```
Replace <site_name> with the name of the site you want to start. This command will navigate to the site's directory and start the Docker containers defined in the Docker Compose file.

Stop a Site:

To stop a running WordPress site, use the following command:

```bash
Copy code
./script.sh stop <site_name>
```
Replace <site_name> with the name of the site you want to stop. This command will navigate to the site's directory and stop the Docker containers associated with the site.

Delete a Site:

To delete a WordPress site and its associated files, use the following command:

```bash
Copy code
./script.sh delete <site_name>
```
Replace <site_name> with the name of the site you want to delete. This command will stop the site if it is running, remove the Docker containers and volumes, and delete the site's directory.

Note: For all the commands above, make sure you provide a valid site name. The site name should be a single word without any spaces or special characters.

## Demo

A sample illustration of the workflow .
Suppose you wanted to create a site named selected.com

Clone the repo

```bash
  git clone https://github.com/geet-h17/rt_camp_devops_assignment
```

Make this script executable before running it.
```bash
chmod u+x script.sh
```

Create the site seleted.com
```bash
Copy code
./script.sh create selected
```
This will create a new directory named selected and set up the necessary Docker containers.

Start the site:

```bash
Copy code
./script.sh start selected
```
This will start the Docker containers for the selected site, making it accessible at http://selected:8080.

Access the WordPress site:

Open a web browser and navigate to http://selected:8080. You should see the WordPress installation page.

Stop the site:

```bash
Copy code
./script.sh stop selected
```
This will stop the Docker containers for the selected site.

Delete the site:

```bash
Copy code
./script.sh delete selected
```
This will remove the Docker containers and volumes associated with the selected site, as well as the directories that were created for storing the content for the site.

That's it! You can now manage your WordPress sites easily using this script.

Please feel free to reach out if you have any further questions or issues with the script.


## Authors

- [@geet-h17](https://www.github.com/geet-h17)


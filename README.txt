NWEA Code Sample Request README
- Alison McCrea, 2/19/2016 for NWEA
=================================================================

Hi! This Nginx Puppet module was tested on VMWare workstation running CentOS 7, 
configured as a standalone server (no puppet master).   

Install prior to puppet run: 
iptables-services (needed for puppet firewall lib)
puppetlabs-stdlib
puppetlabs-firewall

 I think the two puppet libraries are pretty standard nowadays and can be expected on any 
 reasonable setup. If not, they can both be replaced with exec commands (or other libraries).

Place {files,manifests} folders into /etc/puppet/modules/nginx, and run using the command: 

> (sudo) puppet apply -e 'include nginx'

'puppet apply' is used because this is a standalone install. If this were a client-server installation, 
nodes would have 'include nginx' somewhere in their definitions and the nginx module would be called this way. 

Dir structure: /etc/puppet/modules/nginx
	Manifests listed in order of dependency. 

nginx
+-- manifests
|    |-- init.pp 	// defines other manifests
|    |-- add_repo.pp 	// adds yum repo for nginx
|    |-- install.pp     // installs nginx
|    |-- config.pp      // edits nginx's default.conf to listen on port 8888
                        //     and grabs NWEA's test githhub index.html
|    |-- firewall.pp    // opens port 8888 in firewall, makes bindable for http
|    |-- service.pp 	// starts (ensures) nginx service running
+-- files
     |-- nginx_repo 	// textfile for nginx yum repo


FIREWALL NOTE: CentOS7 has SELinux (security enhanced) enabled by default and requires a `semanage` command 
to allow 8888 to able to be binded to as a web port. (Forgive my grammar.)
See: http://serverfault.com/questions/566317/nginx-no-permission-to-bind-port-8090-but-it-binds-to-80-and-8080. 
I don't have any intention of disabling SELinux so I just have puppet exec the command before starting the nginx service. 

CentOS7 also had a problem with iptables not being able to be turned on before firewall.pp ran. 
This was solved by installing iptables-services.

Notifications are there. In a prod env, I'd turn them off. 

Why did you choose this solution?

I really like Puppet - it's human-readable and the layout is intuitive. That being said, I have no idea if 
Chef/Ansible/Salt stack can handle any of these tasks better. I do have to use 'exec' for a few things which isn't elegant. 

What is the best/worst part of your solution?

Unfortunately, Puppet is not the easiest to deal with in terms of dependencies. I spent a long time 
struggling with 'require' until chaining seemed to work, but seems to make it take much longer. 

The initial run also takes ~4 minutes, but that's probably because I didn't allocate very much memory to the VM. 

Otherwise, this is a simple task and Puppet does it well.

Why would automating a task like this be helpful?

Automating this setup is extremely helpful for several reasons. 

(1) Replaces the several commands and checks to do for this task which would take ~5 minutes per machine - 
multiply that by 100 machines, and simple setups become a huge pain.
(2) Not only can you install your initial setup quickly, but if some of your commodity hardware fails, 
you can deploy a new machine almost instantanously.
(3) Probably the most important thing in the devops day - it's easy to make chances. Need to 
change one piece? A config variable, an admin email, a firewall rule? Simply edit a manifest (or a few), 
and either have them all do a manual pull using mcollective/etc, or wait 30 mins and they'll all be updated automatically. 
(4) Monitoring is so much easier. The puppet agent also serves as a monitor and that data can be so nicely 
arranged and you can get nice world-views and health reports of all your machines at once. 

I could go on (Less room for mistakes, happier devops team), but this README is long enough. 

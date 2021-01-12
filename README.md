   REQUIREMENTS <br>
   
Access to AWS via AWS CLI (aws_access_key_id and aws_secret_access_key)<br>
Knowing AMI id of AWS image for build the instance<br>
How to know:<br>
On EC2 Dashboard click on Launch instance button
<img src="https://github.com/Silame83/Mabaya/blob/master/launch_instance.png">

find Ubuntu image and copy to buffer
<img src="https://github.com/Silame83/Mabaya/blob/master/choice_ami.png">
     

1. Download terraform https://www.terraform.io/downloads.html;
2. Move terraform to directory of binary files: mv ~/Downloads/terraform /usr/local/bin/ ;
3. Clone GitHub repository to working directory: git clone https://github.com/Silame83/Mabaya.git
4. Into file <a href="https://github.com/Silame83/Mabaya/blob/master/aws_vpc.tf">aws_vpc.tf</a> change parameter "profile" to the current one that you have and the region, that you need;<br>
     <img src="https://github.com/Silame83/Mabaya/blob/master/profile_in_tf.png">
5. Inside the file <a href="https://github.com/Silame83/Mabaya/blob/master/aws_server.tf">aws_server.tf</a>, replace "ami" value with the previously found value;
     <img src="https://github.com/Silame83/Mabaya/blob/master/replace_ami.png">
6. Into workdir initialize terraform by command: terraform init;
7. Command terraform apply with confirmation, by command "Yes" deploy infrastructure on our AWS cloud;
     <img src="https://github.com/Silame83/Mabaya/blob/master/tf_applying%20.png">


      CHECKING <br>
      
    In AWS account, where deploying was done, enter to EC2 service, choice neccessary instance and click on Connect button(on the top right)
    <img src="https://github.com/Silame83/Mabaya/blob/master/Connect_btn.png">
    
    then, Connect
    <img src="https://github.com/Silame83/Mabaya/blob/master/connect_to_instance.png">
    
    and you are into instance
    <img src="https://github.com/Silame83/Mabaya/blob/master/into_instance.png">
    
    next step, commands:<br>
                    mysql -u ubuntu -p <br>
          in prompt Password: <br>
                    Silame83@gmail.com <br>
          and into MySQL <br>
                    SELECT * FROM mabaya.requests; <br>
    
    
      EXPLANATIONS <br>
     
     In EC2 service exist public IP of instance, open browser, enter <this public IP>:8008 (work port of application) and write something as GET request, all content writes to MySQL Database



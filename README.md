          <h2>Requirements</h2>
     Access to AWS via AWS CLI (aws_access_key_id and aws_secret_access_key)

1. Download terraform https://www.terraform.io/downloads.html;
2. Move terraform to binary derictory mv ~/Downloads/terraform /usr/local/bin/ ;
3. Clone GitHub repository to working directory;
4. Into file <a href="https://github.com/Silame83/Mabaya/blob/master/aws_vpc.tf">aws_vpc.tf</a> change parameter "profile" to the current one that you have and the region is what you need;<br>
     <img src="https://github.com/Silame83/Mabaya/blob/master/profile_in_tf.png">
5. Into workdir initialize terraform by command: terraform init;
6. Command terraform apply with applying by command "Yes" deploying infrastructure on our AWS cloud;
     <img src="https://github.com/Silame83/Mabaya/blob/master/tf_applying%20.png">


               <h2>Checking</h2>
    In AWS account, where depploying was done, join to EC2 service, choice neccessary instance and click on Connect button(on the top right)
    <img src="https://github.com/Silame83/Mabaya/blob/master/Connect_btn.png?raw=true">




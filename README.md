
# AWS Infrastructure Setup Using Terraform

## Objective

This project automates the setup of a scalable, highly available infrastructure for a web application on AWS using Terraform. The infrastructure includes a VPC with public and private subnets, an Application Load Balancer (ALB), Auto Scaling Groups (ASGs) for EC2 instances, an RDS MySQL database in a private subnet, and an S3 bucket for static assets.



## 1. Deployment Instructions

### Step 1: Clone the Repository

Clone the repository containing the Terraform templates to your local machine:

```bash
git clone <repository-url>
cd <repository-directory>
```

### Step 2: Initialize Terraform

In the root directory of the project, initialize Terraform to download necessary provider plugins:

```bash
terraform init
```

### Step 3: Plan the Infrastructure

Preview the changes Terraform will make by running:

```bash
terraform plan
```

Review the infrastructure changes, including the VPC, ALB, EC2 instances, RDS database, and S3 bucket.

### Step 4: Apply the Infrastructure

To create the infrastructure, run the following command:

```bash
terraform apply
```

Terraform will prompt you to type `yes` to confirm the deployment. The infrastructure will then be provisioned in AWS.

### Step 5: Output Details

Once the infrastructure is deployed, Terraform will output important details such as:

- VPC ID
- ALB DNS Name
- RDS Endpoint
- S3 Bucket Name

These values will be necessary for further configuration and validation.

## 2. Configuration

### Customizing the Deployment

You can customize the infrastructure using variables defined in `variables.tf`. For example, you can adjust the instance type, VPC CIDR block, and the number of EC2 instances. Modify these values directly in the file or pass them as arguments during deployment:

```bash
terraform apply -var="instance_type=t3.large" -var="region=us-east-1"
```

### Environment-Specific Configurations

The project is set up to handle multiple environments like **staging** and **production**. Environment-specific Terraform files are located in the `environments/` directory. Each environment can have unique variables, instance sizes, and scaling policies.

To deploy a specific environment, navigate to the desired folder:

```bash
cd environments/production
terraform init
terraform apply
```

## 3. Validation

### 3.1 EC2 Instance Validation

- Go to the EC2 Dashboard in the AWS Console.
- Verify that instances are running in multiple availability zones.
- Check that the Auto Scaling Group is managing the instances, ensuring scalability.

### 3.2 ALB Validation

- Visit the ALB DNS name (provided in Terraform output) in your web browser.
- Verify that the ALB is distributing traffic across multiple EC2 instances.

```bash
http://<alb-dns-name>
```

### 3.3 RDS Validation

- Use the MySQL client to connect to the RDS endpoint provided by Terraform:

```bash
mysql -h <rds-endpoint> -u admin -p
```

- Ensure the RDS instance is in the private subnet and is only accessible from the EC2 instances.

### 3.4 S3 Bucket Validation

- Upload a file to the S3 bucket and verify that it is publicly accessible:

```bash
aws s3 cp <file-path> s3://<bucket-name>/
```

- Check that you can access the file via the web browser:

```bash
http://<bucket-name>.s3.amazonaws.com/<file-name>
```

## 4. Teardown

To remove all resources created by Terraform, run:

```bash
terraform destroy
```

This will delete the VPC, EC2 instances, RDS databases, and S3 bucket.



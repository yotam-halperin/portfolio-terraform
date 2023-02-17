
### CrossyRoad Application Pricing ###

- node group EC2 instances:
<!-- t3.2xlarge - $0.3776832 hourly -->
t3a.2xlarge - $0.3398832 hourly

- node group EBS volumes:
$0.10 per GB-month of provisioned storage

- secret manager:
The storage cost is $0.40 per secret per month and API interactions cost is $0.05 per 10,000 API calls.

- parameter store:
FREE (standard parameter)

- EKS cluster:
You pay $0.10 per hour for each Amazon EKS cluster that you create.

- load balancer:
$0.0294 per Classic Load Balancer-hour (or partial hour)
$0.0084 per GB of data processed by a Classic Load Balancer

- Route53 hosted zone:
$0.50 per hosted zone / month for the first 25 hosted zones

- EC2 elastic IP for jenkins
not charged anless machine has stoped

- EC2 Jenkins instance
t3a.2xlarge - $0.3398832 hourly ### change to medium

# ways to reduce cost:

- EC2 saving plans
- reserved instances
- ASG scaling matrix
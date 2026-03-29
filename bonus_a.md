i-073f5fa3e014fee53
recovery_window_in_days = 0

aws secretsmanager delete-secret \
--secret-id lab/rds/mysql \
--force-delete-without-recovery

1. Prove EC2 is private (no public IP)
aws ec2 describe-instances \
  --instance-ids i-073f5fa3e014fee53 \
  --query "Reservations[].Instances[].PublicIpAddress"

--query "Reservations[].Instances[].PublicIpAddress"
{
    "Reservations": [
        {
            "ReservationId": "r-05635b07eefd1fab1",
            "OwnerId": "313476888487",
            "Groups": [],
            "Instances": [
                {
                    "Architecture": "x86_64",
                    "BlockDeviceMappings": [
                        {
                            "DeviceName": "/dev/xvda",
                            "Ebs": {
                                "AttachTime": "2026-01-22T01:53:33+00:00",
                                "DeleteOnTermination": true,
                                "Status": "attached",
                                "VolumeId": "vol-01bb0e175d0f9b2ec"
                            }
                        }
                    ],
                    "ClientToken": "terraform-20260122015332702100000004",
                    "EbsOptimized": false,
                    "EnaSupport": true,
                    "Hypervisor": "xen",
                    "IamInstanceProfile": {
                        "Arn": "arn:aws:iam::313476888487:instance-profile/chewbacca-instance-profile01",
                        "Id": "AIPAUR7FNW6T3EZFFPLHA"
                    },
                    "NetworkInterfaces": [
                        {
                            "Attachment": {
                                "AttachTime": "2026-01-22T01:53:32+00:00",
                                "AttachmentId": "eni-attach-0d743152f09b70c43",
                                "DeleteOnTermination": true,
                                "DeviceIndex": 0,
                                "Status": "attached",
                                "NetworkCardIndex": 0
                            },
                            "Description": "",
                            "Groups": [
                                {
                                    "GroupId": "sg-00cdec2059b26a1d5",
                                    "GroupName": "chewbacca-ec2-sg01"
                                }
                            ],
                            "Ipv6Addresses": [],
                            "MacAddress": "0e:c6:2a:da:83:8f",
                            "NetworkInterfaceId": "eni-07621c84aeb81b4cf",
                            "OwnerId": "313476888487",
                            "PrivateDnsName": "ip-10-161-11-19.ec2.internal",
                            "PrivateIpAddress": "10.161.11.19",
                            "PrivateIpAddresses": [
                                {
                                    "Primary": true,
                                    "PrivateDnsName": "ip-10-161-11-19.ec2.internal",
                                    "PrivateIpAddress": "10.161.11.19"
                                }
                            ],
                            "SourceDestCheck": true,
                            "Status": "in-use",
                            "SubnetId": "subnet-0d9cf5a7d808d4503",
                            "VpcId": "vpc-0d6abcc8476112ac3",
                            "InterfaceType": "interface",
                            "Operator": {
                                "Managed": false
                            }
                        }
                    ],
                    "RootDeviceName": "/dev/xvda",
                    "RootDeviceType": "ebs",
                    "SecurityGroups": [
                        {
                            "GroupId": "sg-00cdec2059b26a1d5",
                            "GroupName": "chewbacca-ec2-sg01"
                        }
                    ],
                    "SourceDestCheck": true,
                    "Tags": [
                        {
                            "Key": "Name",
                            "Value": "chewbacca-ec201_private_bonus"
                        }
                    ],
                    "VirtualizationType": "hvm",
                    "CpuOptions": {
                        "CoreCount": 1,
                        "ThreadsPerCore": 2
                    },
                    "CapacityReservationSpecification": {
                        "CapacityReservationPreference": "open"
                    },
                    "HibernationOptions": {
                        "Configured": false
                    },
                    "MetadataOptions": {
                        "State": "applied",
                        "HttpTokens": "required",
                        "HttpPutResponseHopLimit": 2,
                        "HttpEndpoint": "enabled",
                        "HttpProtocolIpv6": "disabled",
                        "InstanceMetadataTags": "disabled"
                    },
                    "EnclaveOptions": {
                        "Enabled": false
                    },
                    "BootMode": "uefi-preferred",
                    "PlatformDetails": "Linux/UNIX",
                    "UsageOperation": "RunInstances",
                    "UsageOperationUpdateTime": "2026-01-22T01:53:32+00:00",
                    "PrivateDnsNameOptions": {
                        "HostnameType": "ip-name",
                        "EnableResourceNameDnsARecord": false,
                        "EnableResourceNameDnsAAAARecord": false
                    },
                    "MaintenanceOptions": {
                        "AutoRecovery": "default",
                        "RebootMigration": "default"
                    },
                    "CurrentInstanceBootMode": "uefi",
                    "NetworkPerformanceOptions": {
                        "BandwidthWeighting": "default"
                    },
                    "Operator": {
                        "Managed": false
                    },
                    "InstanceId": "i-073f5fa3e014fee53",
                    "ImageId": "ami-07ff62358b87c7116",
                    "State": {
                        "Code": 16,
                        "Name": "running"
                    },
                    "PrivateDnsName": "ip-10-161-11-19.ec2.internal",
                    "PublicDnsName": "",
                    "StateTransitionReason": "",
                    "AmiLaunchIndex": 0,
                    "ProductCodes": [],
                    "InstanceType": "t3.micro",
                    "LaunchTime": "2026-01-22T01:53:32+00:00",
                    "Placement": {
                        "AvailabilityZoneId": "use1-az6",
                        "GroupName": "",
                        "Tenancy": "default",
                        "AvailabilityZone": "us-east-1a"
                    },
                    "Monitoring": {
                        "State": "disabled"
                    },
                    "SubnetId": "subnet-0d9cf5a7d808d4503",
                    "VpcId": "vpc-0d6abcc8476112ac3",
                    "PrivateIpAddress": "10.161.11.19"
                }
            ]
        }
    ]
}





bash: --query: command not found



2. Prove VPC endpoints exist
aws ec2 describe-vpc-endpoints \
  --filters "Name=vpc-id,Values= vpc-0d6abcc8476112ac3" \
  --query "VpcEndpoints[].ServiceName" vpc-0d6abcc8476112ac3

"com.amazonaws.us-east-1.s3",
"com.amazonaws.us-east-1.ssm",
"com.amazonaws.us-east-1.ssmmessages",
"com.amazonaws.us-east-1.ec2messages",
"com.amazonaws.us-east-1.kms",
"com.amazonaws.us-east-1.secretsmanager",
"com.amazonaws.us-east-1.logs"
]
3. Prove Session Manager path works (no SSH)

  aws ssm describe-instance-information \
  --query "InstanceInformationList[].InstanceId"

"i-073f5fa3e014fee53"

4. Prove the instance can read both config stores Run from SSM session:

aws ssm get-parameter --name /lab/db/endpoint
aws secretsmanager get-secret-value --secret-id chewbacca/lab/rds/sql

	{
    "ARN": "arn:aws:secretsmanager:us-east-1:313476888487:secret:chewbacca/lab/rds/sql-MXvG34",
    "Name": "chewbacca/lab/rds/sql",
    "VersionId": "terraform-20260122015841915600000006",
    "SecretString": "{\"dbname\":\"labdb\",\"host\":\"chewbacca-rds01.c0j6g4uegv7l.us-east-1.rds.amazonaws.com\",\"password\":\"Putituplion45\",\"port\":3306,\"username\":\"admin\"}",
    "VersionStages": [
        "AWSCURRENT"
    ],
    "CreatedDate": "2026-01-21T20:58:40.866000-05:00"
}


5. Prove CloudWatch logs delivery path is available via endpoint
  aws logs describe-log-streams \
    --log-group-name /aws/ec2/<prefix>-rds-app

"/aws/ec2/${local.name_prefix}-rds-app"


How this maps to “real company” practice (short, employer-credible)
  Private compute + SSM is standard in regulated orgs and mature cloud shops.
  VPC endpoints reduce exposure and dependency on NAT for AWS APIs.
  Least privilege is not optional in security interviews.
  Terraform submission mirrors how teams ship changes: PR → plan → review → apply → monitor.

 

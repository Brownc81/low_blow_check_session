01292026
{1b questions} Student verification (CLI) 

DNS validation (best): create Route53 hosted zone + validation records in Terraform
We needed to use TLS to get the If your project involves
Cloud Security Assessments or Backend APIs, TLS is your first line of defense. Without it, your API keys and sensitive enterprise data are sent as "Plaintext," meaning anyone "listening" on the network can read them easily.

Deliverables
Verification commands (CLI) for Bonus-B
1) ALB exists and is active
   
$ aws elbv2 describe-load-balancers \
        --names chewbacca-alb01 \
        --query "LoadBalancers[0].State.Code"
Bash Answer
"active"

3) HTTPS listener exists on 443
$ aws elbv2 describe-listeners         --load-balancer-arn  arn:aws:elasticloadbalancing:us-east-1:313476888487:loadbalancer/app/chewbacca-alb01/03d1d799c250f892         --query "Listeners[].Port"
Bash Answer
[
    443,
    80
]

4) Target is healthy
   
      aws elbv2 describe-target-health \
        --target-group-arn  arn:aws:elasticloadbalancing:us-east-1:313476888487:targetgroup/chewbacca-tg01/82c4c8d523f1b91d

arn:aws:elasticloadbalancing:us-east-1:313476888487:targetgroup/chewbacca-tg01/82c4c8d523f1b91d

{
    "TargetHealthDescriptions": [
        {
            "Target": {
                "Id": "i-02df492934ccb46c2",
                "Port": 80
            },
            "HealthCheckPort": "80",
            "TargetHealth": {
                "State": "unhealthy",
                "Reason": "Target.ResponseCodeMismatch",
                "Description": "Health checks failed with these codes: [404]"
            },
            "AdministrativeOverride": {
                "State": "no_override",
                "Reason": "AdministrativeOverride.NoOverride",
                "Description": "No override is currently active on target"
            }
        }
    ]
}



5) WAF attached
   
      aws wafv2 get-web-acl-for-resource \
        --resource-arn arn:aws:elasticloadbalancing:us-east-1:313476888487:loadbalancer/app/chewbacca-alb01/03d1d799c250f892

{
    "WebACL": {
        "Name": "chewbacca-waf01",
        "Id": "a88f44fc-6899-49f6-be0a-4c6c735038f6",
        "ARN": "arn:aws:wafv2:us-east-1:313476888487:regional/webacl/chewbacca-waf01/a88f44fc-6899-49f6-be0a-4c6c735038f6",
        "DefaultAction": {
            "Allow": {}
        },
        "Description": "",
        "Rules": [
            {
                "Name": "AWSManagedRulesCommonRuleSet",
                "Priority": 1,
                "Statement": {
                    "ManagedRuleGroupStatement": {
                        "VendorName": "AWS",
                        "Name": "AWSManagedRulesCommonRuleSet"
                    }
                },
                "OverrideAction": {
                    "None": {}
                },
                "VisibilityConfig": {
                    "SampledRequestsEnabled": true,
                    "CloudWatchMetricsEnabled": true,
                    "MetricName": "chewbacca-waf-common"
                }
            }
        ],
        "VisibilityConfig": {
            "SampledRequestsEnabled": true,
            "CloudWatchMetricsEnabled": true,
            "MetricName": "chewbacca-waf01"
        },
        "Capacity": 700,
        "ManagedByFirewallManager": false,
        "LabelNamespace": "awswaf:313476888487:webacl:chewbacca-waf01:",
        "RetrofittedByFirewallManager": false,
        "OnSourceDDoSProtectionConfig": {
            "ALBLowReputationMode": "ACTIVE_UNDER_DDOS"
        }
    }
}


7) Alarm created (ALB 5xx)
   
      aws cloudwatch describe-alarms \
        --alarm-name-prefix chewbacca-alb-5xx

{
    "MetricAlarms": [
        {
            "AlarmName": "chewbacca-alb-5xx-alarm01",
            "AlarmArn": "arn:aws:cloudwatch:us-east-1:313476888487:alarm:chewbacca-alb-5xx-alarm01",
            "AlarmConfigurationUpdatedTimestamp": "2026-01-29T15:15:55.382000-05:00",
            "ActionsEnabled": true,
            "OKActions": [],
            "AlarmActions": [
                "arn:aws:sns:us-east-1:313476888487:chewbacca-db-incidents"
            ],
            "InsufficientDataActions": [],
            "StateValue": "INSUFFICIENT_DATA",
            "StateReason": "Unchecked: Initial alarm creation",
            "StateUpdatedTimestamp": "2026-01-29T15:15:55.382000-05:00",
            "MetricName": "HTTPCode_ELB_5XX_Count",
            "Namespace": "AWS/ApplicationELB",
            "Statistic": "Sum",
            "Dimensions": [
                {
                    "Name": "LoadBalancer",
                    "Value": "app/chewbacca-alb01/03d1d799c250f892"
                }
            ],
            "Period": 300,
            "EvaluationPeriods": 1,
            "Threshold": 10.0,
            "ComparisonOperator": "GreaterThanOrEqualToThreshold",
            "TreatMissingData": "missing",
            "StateTransitionedTimestamp": "2026-01-29T15:15:55.382000-05:00"
        }
    ],
    "CompositeAlarms": []
}



9) Dashboard exists
    aws cloudwatch list-dashboards \
        --dashboard-name-prefix chewbacca
cbventures.click

Bash Answer
{
    "DashboardEntries": [
        {
            "DashboardName": "chewbacca-dashboard01",
            "DashboardArn": "arn:aws:cloudwatch::313476888487:dashboard/chewbacca-dashboard01",
            "LastModified": "2026-01-29T16:32:52-05:00",
            "Size": 672
        }
    ]
}

bash: cbventures.click: command not found


{1c questions} Student verification (CLI) 

1) Confirm hosted zone exists (if managed)
  aws route53 list-hosted-zones-by-name \
    --dns-name app.cbventures.click \
    --query "HostedZones[].Id"

Bash Answer

[Bad value for --query ResourceRecordSets[?Name==' app.cbventures.click.]: Bad jmespath expression: Unclosed ' delimiter:
ResourceRecordSets[?Name==' app.cbventures.click.]


2) Confirm app record exists
  aws route53 list-resource-record-sets \
  --hosted-zone-id Z0512201FXFQUJ6HG6NP \
  --query "ResourceRecordSets[?Name==' app.cbventures.click.']"

3) Confirm certificate issued
  aws acm describe-certificate \
  --certificate-arn arn:aws:acm:us-east-1:313476888487:certificate/3a8c5b7c-4e3f-4c1a-8624-14c94fa5504e \
  --query "Certificate.Status"

Bash Response

ISSUED

4) Confirm HTTPS works
  curl -I https:// https://cbventures.click

Bash Answer

curl: (3) URL rejected: No host part in the URL
HTTP/1.1 200 OK
Date: Fri, 30 Jan 2026 18:22:14 GMT
Content-Type: text/html; charset=utf-8
Content-Length: 233
Connection: keep-alive
Server: Werkzeug/3.1.5 Python/3.9.25

What YOU must understand (career point)
This is exactly how companies do it:
  DNS points to ingress
  TLS via ACM
  ALB handles secure public entry
  private compute does the work
  WAF + alarms defend and alert

When students can Terraform this, they’re doing real cloud engineering.


![alt text](image-12.png)
![alt text](image-13.png)
![alt text](image-14.png)
![alt text](image-15.png)
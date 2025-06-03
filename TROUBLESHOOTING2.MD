# TROUBLESHOOTING.md

This file documents real issues encountered while setting up the Application Load Balancer (ALB) with Auto Scaling EC2 instances using Terraform.

---

## 1. 🚫 ALB Shows 504 Gateway Timeout

**Cause:** ALB could not reach the EC2 instances due to missing web server or incorrect SG.

**Fix:**

* Ensure `user_data` installs and starts Apache/Nginx.
* EC2 Security Group must allow inbound port 80.
* Health check path `/` should return 200.

---

## 2. 🚫 EC2 Instance Marked as Unhealthy in ALB

**Cause:** Instance not responding to ALB health checks.

**Fix:**

* Double-check that Apache is running (`curl localhost` on instance).
* Ensure EC2 SG allows inbound from ALB SG.
* Validate health check path and port in target group.

---

## 3. ⚠️ Error: Missing Required Argument `alb_security_group_ids`

**Cause:** Required variable not passed to ALB module.

**Fix:**
In `alb.tf`, ensure this is present:

```hcl
alb_security_group_ids = [module.vpc.default_security_group_id]
```

---

## 4. ⚠️ Error: Invalid Count Argument

**Cause:** `count` depends on unknown value during plan.

**Fix:** Avoid using `count` with values from another module during the same apply. Use `-target` for staged apply or refactor with `for_each`.

---

## 5. ⚠️ ALB DNS Shows Nothing / Times Out

**Cause:** EC2 may not have public access or user\_data may not have run.

**Fix:**

* Ensure subnet is public and IGW is attached.
* Confirm `associate_public_ip_address = true` in launch template.
* Review EC2 instance system logs.

---

## 6. ⚠️ Security Group Not Attached Properly

**Cause:** SG was declared but not referenced in launch template.

**Fix:** Use this inside `aws_launch_template`:

```hcl
security_groups = [aws_security_group.this.id]
```

---

## 7. ⚠️ ALB Creation Fails - "No Internet Gateway"

**Cause:** Trying to create ALB before VPC/IGW exists.

**Fix:** Apply VPC module first, or ensure correct dependency flow.

---

## 8. 🔁 Infra Doesn't Update After User Data Fix

**Cause:** ASG does not recreate EC2 automatically.

**Fix:**

* Use `terraform taint` on ASG or change desired capacity to trigger replacement.

---

## 9. ❌ Destroy Doesn't Work Due to Missing Outputs

**Cause:** Referencing outputs that no longer exist.

**Fix:**

* Use `terraform state rm` or delete manually via AWS Console.
* Or recreate entire stack cleanly.

---

##  Clean Apply Flow

```bash
terraform init -reconfigure
terraform validate
terraform plan -var-file="terraform.tfvars"
terraform apply -var-file="terraform.tfvars"
```

---

## Clean Destroy

```bash
terraform destroy -var-file="terraform.tfvars"
```

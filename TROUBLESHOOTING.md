# ❗ Troubleshooting & Lessons Learned

This document captures the real-world issues encountered while building the AWS infrastructure using Terraform — and how they were resolved.

---

### 1. ❌ Missing required argument: `azs`
- **Problem**: Terraform validation failed because `azs` wasn’t defined.
- **Fix**: Declared `azs` as a list in both `variables.tf` and `terraform.tfvars`.

---

### 2. ❌ Reference to undeclared input variable
- **Problem**: Referenced `var.vpc_id` and `var.subnet_ids` without defining them.
- **Fix**: Used `module.vpc.vpc_id` and `module.vpc.public_subnet_ids` directly.

---

### 3. ❌ terraform_remote_state has no attribute
- **Problem**: Output attributes were missing from remote state.
- **Fix**: Removed `terraform_remote_state` block and used live `module.vpc.*` outputs instead.

---

### 4. ❌ No module call named `vpc`
- **Problem**: Referred to `module.vpc.*` after commenting out the VPC module.
- **Fix**: Either re-enabled the module or removed the broken references.

---

### 5. ❌ Unsupported argument: `vpc_id`
- **Problem**: Passed `vpc_id` to the EC2 module, but it wasn't declared there.
- **Fix**: Declared `vpc_id` as an input variable in the `ec2-autoscaling` module.

---

### 6. ❌ Module cannot access another module
- **Problem**: Tried referencing `module.vpc.vpc_id` inside the EC2 module.
- **Fix**: Moved the dependency to the root module and passed values as inputs.

---

### 7. ❌ Terraform asked for input at runtime
- **Problem**: Got interactive prompts for `subnet_ids`, `vpc_id`, etc.
- **Fix**: Replaced `var.*` references with `module.vpc.*` where applicable, and removed unused variables.

---

### 8. ❌ terraform destroy failed
- **Problem**: Terraform couldn’t destroy the VPC because the structure/output changed after apply.
- **Fix**: Deleted the VPC manually via AWS Console and cleaned local `.terraform` state.

---

### ✅ Bonus Tips
- Use `terraform plan -destroy -out=destroy.tfplan` before `terraform apply destroy.tfplan`
- Use `terraform graph | dot -Tpng > graph.png` to visualize dependencies
- Always pass outputs between modules through the **root module**, not directly


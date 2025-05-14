# Week 11 - MERN Stack Blog App Deployment on AWS

## ✅ Success Criteria Checklist

*  **MERN app is deployed and accessible**
*  **MongoDB Atlas is successfully connected**
*  **Media uploads are functional using S3**
*  **Frontend loads from S3 bucket**
*  **Screenshots submitted include:**

  *  PM2 showing backend running
  *  MongoDB cluster
  *  Media upload success
  *  S3 frontend in browser

---

## 📦 Infrastructure Setup

### 1. **Terraform Configuration**

* **provider.tf**: Configured AWS provider for `eu-north-1` region.
* **keypair.tf**: Uploaded `new-mern-key.pem.pub` key pair.
* **security.tf**: Security group created with HTTP (80), SSH (22), and App port (5000).
* **ec2.tf**: Deployed EC2 instance with user_data to clone the MERN app.
* **s3.tf**:

  * `mern-media-joud-2025` (for media uploads)
  * `mern-frontend-joud-2025` (for hosting frontend)
* **iam.tf**:

  * IAM user created with policy allowing access to the media bucket.
* **outputs.tf**: Outputs for public IP and IAM access keys.

### Commands Used:

```bash
terraform init
terraform apply
```

---

## 🧪 Testing Access

* SSH to EC2:

```bash
ssh -i ~/terraform/week11/new-mern-key.pem ubuntu@13.60.233.2
```

* `.env` file contents were added in EC2 using Ansible:

```env
PORT=5000
MONGODB_URL=mongodb+srv://test:qazqwe123@mongodb.txkjsso.mongodb.net/blog-app

AWS_BUCKET_NAME=mern-media-joud-2025
```

---

## ⚙️ Backend Setup (Manual & Ansible)

### Using Ansible:

* `inventory.ini`: Contains public IP of EC2.
* `playbook.yml`:

  * Installs dependencies
  * Creates `.env`
  * Starts app using `pm2`

### Manual Commands Run in EC2:

```bash
cd ~/blog-app-MERN/backend
npm install -g pm2
npm install
mkdir -p logs
pm2 start index.js --name "blog-backend"
pm2 save
```

---

## 🌐 Frontend Setup

### Inside EC2 Frontend Directory:

```bash
cd ~/blog-app-MERN/frontend
npm install -g pnpm@latest-10
pnpm install
pnpm run build
aws s3 sync dist/ s3://mern-frontend-joud-2025
```

* Enabled Static Website Hosting in S3

---

## ✅ Final Verification

*  `terraform output ec2_public_ip` works
*  `.env` exists with correct values
*  PM2 is running the backend
*  S3 bucket is public and frontend loads
*  Media uploads to S3 bucket confirmed

---
**Name:** Joud Alwasmi 
**Generated on:** 2025-05-14

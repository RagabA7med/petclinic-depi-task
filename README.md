### Project Idea

* Run **3 independent Petclinic applications** (`App1`, `App2`, `App3`).
* Each application is connected to its own **dedicated MySQL database** (`DB1`, `DB2`, `DB3`).
* Applications are separated into **different Docker networks** to simulate isolated environments.
* A custom Dockerfile is used to build the Petclinic application from source using Maven.
* The setup allows testing and verifying:

  * Each app runs on its own port (`8081`, `8082`, `8083`).
  * Each app connects only to its own database.
  * Networking between apps can be controlled (e.g., testing connectivity between App1 and App3).


### 🔹 Step 1) Create the Project Folder
<img width="690" height="79" alt="image" src="https://github.com/user-attachments/assets/16ca5c08-506b-4230-8403-87cb29b493b4" />


### 🔹 Step 2) Create a Dockerfile

Create a file named **Dockerfile**:

<img width="693" height="64" alt="image" src="https://github.com/user-attachments/assets/ac0ffc67-d106-4644-83a4-66489da4510e" />

then Create a **Dockerfile MultiStage**:

<img width="1006" height="427" alt="image" src="https://github.com/user-attachments/assets/7f5f2770-8c72-447f-baf0-79ceb00b318f" />

### 🔹 Step 3) Build the Application Image
<img width="1007" height="919" alt="image" src="https://github.com/user-attachments/assets/8309c6d4-cfac-4dc4-981f-c5815c9dbe9d" />


### 🔹 Step 4) Create Networks

We need two networks:
net 1
net 2
and verify 
<img width="861" height="221" alt="image" src="https://github.com/user-attachments/assets/f951bb12-369a-48f0-8f00-973806d80643" />


### 🔹 Step 5) Create Databases

Create **DB1** on **net1**:
<img width="960" height="457" alt="image" src="https://github.com/user-attachments/assets/f6fb4786-e6ec-49aa-8494-ad87175c69d6" />

Create **DB2** on **net1**:
<img width="968" height="160" alt="image" src="https://github.com/user-attachments/assets/c36c60af-68e3-4ca6-a2ca-f09e87013b55" />

Create **DB3** on **net2**:
<img width="974" height="161" alt="image" src="https://github.com/user-attachments/assets/274be44d-c24e-4e10-bd76-e47f4cd07582" />


### 🔹 Step 6) Create a Shared Volume

```bash
docker volume create shared-data
```


### 🔹 Step 7) Run the Applications

**App1** (connects to **DB1** on **net1**):
<img width="1198" height="203" alt="image" src="https://github.com/user-attachments/assets/1121fa0b-9b82-42e3-ad09-e213b30fe4d5" />


**App2** (connects to **DB2** on **net1**):
<img width="1221" height="200" alt="image" src="https://github.com/user-attachments/assets/1fafb83a-884e-4dff-a6da-4c9c050c3ee6" />


**App3** (connects to **DB3** on **net2**):
<img width="1193" height="181" alt="image" src="https://github.com/user-attachments/assets/ceb63f4e-5392-491c-af93-b642aeaf5dff" />


### 🔹 Step 8) Connect the Networks

Now we have:

* **net1** → (app1, app2, db1, db2)
* **net2** → (app3, db3)

We can connect them if needed. 

Connect **app1** to **net2**:

```bash
docker network connect net2 app1
```

Or connect **app3** to **net1**:

```bash
docker network connect net1 app3
```


### 🔹 Step 9) Test Access

* [http://localhost:8081](http://localhost:8081) → **App1** with **DB1**
* [http://localhost:8082](http://localhost:8082) → **App2** with **DB2**
* [http://localhost:8083](http://localhost:8083) → **App3** with **DB3**

#   The Corrector

  The Tests-over-SSH Platform (c) is a custom made program.
  It was build specifically to create an environment where tasks involving
  computer commands can be performed, and to correct multiple choice or direct
  questions. It works as a replacement to the printed version of the analogous
  practical tests that inspired the platform,  which have to be performed
  resorting to a computer either way.
   

#   Prerequisites

  This program is made of a series of bash scripts. It uses a lot of open 
  source tools, most of them commonly available in a typical installation of
  a Linux system such as Arch Linux. It thus presumes that the environment 
  where it runs has a Linux operating system with bash and the tools mentioned
  in **prerequisites/Prerequisites.md**. It also assumes root access to the 
  system at installation and Setup.

  The installation scripts were written in **bash** scripts (which is thus a 
  prerequisite). Additionally, backing up data and other stuff requires 
  additional tools such as **zip**, **rm** or **mv**.

  Finally, the program was initially thought to operate in a dedicated 
  environment and creating its own local network for increased isolation of
  the students to the Internet. This functionality is achieved via scripts
  only and require additional tools to be installed, such as **hostapd** 
  and **create_ap**. 

  The entire system was tested in a Raspberry Pi 3 with the following kernel:
  **Linux 4.14.62-1-ARCH armv7l GNU/Linux**

  The full list of dependencies can be found in 
  **Dependencies\dependencies.md**


#   Suggested Workflow

  Parts of the workflow are mentioned during the execution of the several
  scripts, but here follows the **suggested workflow** for setting up the
  program, running the tests and wrapping up the results at the end:


##  Fase I - Installation 

  1. Install a Linux system in a suitable and networked computer;

  2. Install and assure correct configuration of all dependencies
  (see **Dependencies/dependencies.md**), namely SSH;

  3. Fire up an SSH server, e.g., 
  `> systemctl start sshd`


##  Fase II - Tests Setup

  1. Setup the **CLI based Testing Platform** folder tree and its contents at
  **/home/**;

  2. Adapt templates from the **Tests** and **Staging** folders to your need. 
  Only files in the **Staging** folder will make their way into the final tests.
  Notice and assure adherence to the terminoloy and notation in the provided
  examples:
    * **01-MCQ.sh** - refers to question **1**, which is a **M**ultiple 
    **C**hoice **Q**uestion;
    * **02-MCT.sh** - refers to question **2**, which is a **T**ask with a 
    **M**ultiple **C**hoice **Q**uestion;
    * **03-DAQ.sh** - refers to question **3**, which is a **D**irect 
    **A**nswer **Q**uestion;
    * **04-DAT.sh** - refers to question **4**, which is a **T**ask with a 
    **D**irect **A**nswer **Q**uestion.

  3. Place a **comma separated values** file called **students.cvs** in
  the **Admin** folder. 

  4. Navigate into **The Corrector/Admin** folder with a terminal. Run the
  script 
  `> ./0-create-database.sh`

  5. One may now print the passwords/codes for each student to access the 
  app. For that, just run the script
  `> ./0-show-codes.sh` on `CLI-based-Testing-Platform/Admin`
  Do not forget to print the output and provide only each password 
  individually. For increased security, each student should make the login 
  only under supervision of the Professor.

  6. If all goes well, go into the root folder of the 
  **CLI based Testing Platform** and run the script 
  `> ./1-run-me-first.sh`.

  7. Run the script
  `> ./2-create-access-point.sh` avaible in the root folder of the platform
  You should now be able to join a **CLItests** wifi network with 
  password **CLItests**.  

  8. You may also want to see the `log.md` file in real time. Use the monitor
  script for that purpose:
  `> ./3-monitor.sh`

  9. Test the app by opening a terminal and logging in with **ssh** into the 
  gateway using the **guest** account (all students use this account to login):
  `> ssh guest@ip_address`
  e.g.,
  `> ssh guest@192.168.12.1`

  10. When asked for a code, use `letmein`. A test user with username `12589`
  and password `letmein` is created automatically for testing purposes.


##  Fase III - During Tests 

  1. During tests, one may need to add a new student or reset the a given 
  test. Two commodity scripts were provided for that purpose on the `Admin`
  folder:
  `> ./insert-student.sh` (for inserting a student);
  `> ./reset-student.sh` (for resetting a student).


##  Fase IV - Wrapping Up

  Once all tests were finished, folders need to be cleaned up and a zip file
  with evidences of tests submitted in the tool needs to be created. For that:

  1. Run `5-cleanup.sh` from the **CLI based Testing Platform** root folder.
  (A zip file is created on the root folder and the resulting database with 
  scores is placed there and in folder `Admin`).

  2. You may run several scripts from the **Admin** folder, namely:
  `> ./see-results.sh` (to see a summary of all results and export them);
  `> ./see-all.sh`     (to see scores per question for all students).

#   Copyright Notice

  Developed by Pedro R. M. Inácio and Joana Costa (copyright)"
  Department of Computer Science"
  Universidade da Beira Interior"

  2020

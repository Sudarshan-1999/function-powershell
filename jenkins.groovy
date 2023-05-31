pipeline{
	agent { label 'High_IPC_DevI9' }
	options {
		timestamps()
		buildDiscarder logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '7', numToKeepStr: '7')
		disableConcurrentBuilds()
		timeout(60)
	}
	parameters {
        string description: 'Git Commit to Build', name: 'COMMIT_ID'
    }
	
	stages{
		
		// stage ('Setup_Repo') {
		// 	steps {
		// 		bat 'AppFx\\Scripts\\Setup_Repo_SHA.bat %COMMIT_ID%'
		// 	}
		// }
		
		// stage ('Build') {
		// 	steps {
		// 		bat """Scripts\\Jobs\\HighMid_DIC_Win_Qt_CMake.bat Jenkins Release %BUILD_TIMESTAMP%_%BUILD_NUMBER% x64 ON"""
		// 	}
		// }
		
		// stage ('Unit Test casses') {
		// 	steps {
		// 		bat """copy build\\win\\AppFx\\googletest\\gtest.dll build\\win\\AppMainLib\\UnitTests\\"""
		// 		bat """if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%"""
		// 		bat """cd build\\win\\AppMainLib\\UnitTests
		// 		HmiAppTest.exe"""
		// 	}
		// }
		
		// stage ('Artifacts') {
		// 	steps {
		// 		bat """ ..\\Archive_Artifacts_Win_Qt_CMake.bat HighMid_DIC_Win_Qt_Develop_%BUILD_TIMESTAMP%_%BUILD_NUMBER% Release x64 """
		// 	}
		// }
		
		stage ('BT1CC(Bev)-5') {
			steps {
				bat """cd ../SAS_IPC
					git fetch -p
					git clean -dfx
					git pull origin master
				"""
				bat """cd HighMid_DIC_Win_Qt_Develop_%BUILD_TIMESTAMP%_%BUILD_NUMBER%
					Set_Calibration.bat BT1CC(Bev)-5"""
				bat	"""cd HighMid_DIC_Win_Qt_Develop_%BUILD_TIMESTAMP%_%BUILD_NUMBER%
				HMIC.exe"""
			}
		}
		
		
	}
	post {
		always{
	            script {
				if (currentBuild.currentResult == 'FAILURE') {
                    def logFilePath = "HighMid_DIC_Win_Qt_Develop_*\\HMIC.txt"
                if (fileExists(logFilePath)) {
                emailext (
                 subject: "Automation Log",
                 body: "Please find the automation log attached.",
                 attachmentsPattern: logFilePath,
                 attachLog: true
                 recipientProviders: [[$class: 'DevelopersRecipientProvider'],
                [$class: 'RequesterRecipientProvider']]
                 )   
             } else {
             echo "Log file not found at: ${logFilePath}"
             }
              }
         }
	}
}
}

if (currentBuild.currentResult == 'FAILURE') {
			            emailext attachLog: true, attachmentsPattern: 'HMIC.log', body:
			            """<p>EXECUTED: Job:Build ID:Commit Id <b>\'${env.JOB_NAME}:${env.BUILD_NUMBER}:${params.COMMIT_ID}\'
			            </b></p><p>View console output at "<a href="${env.BUILD_URL}">
			            ${env.JOB_NAME}:${env.BUILD_NUMBER}</a>"</p>
			            <p><i>(Build log is attached.)</i></p>""",
			            compressLog: true,
			            recipientProviders: [[$class: 'DevelopersRecipientProvider'],
			            [$class: 'RequesterRecipientProvider']],
			            replyTo: 'do-not-reply@company.com',
			            subject: "Status: ${currentBuild.result} - Job:Build ID:Commit Id \'${env.JOB_NAME}:${env.BUILD_NUMBER}:${params.COMMIT_ID}\'",
			            //to: 'shiva.teegala@rampgroup.com vijay.chinimilli@rampgroup.com'
			            to: 'balu.thodupoonuri@rampgroup.com teja.eduru@rampgroup.com'
}
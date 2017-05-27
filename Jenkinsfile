#!groovy

import hudson.Util;

try {

currentBuild.result = "SUCCESS"


  node('armagh-builder') {

     stage('Prep') {

       deleteDir()
     
       checkout scm

       sh """#!/bin/bash -l
         echo -e "*********************************************\n** Preparing:" `hg identify -i` "\n*********************************************"
         set -e
         gem install bundler --no-doc
         bundle install
         ruby --version
         mongod --version
       """
     }
  
     stage('Unit Test') {
     
       sh """#!/bin/bash -l
         echo -e "*********************************************\n** Unit testing:" `hg identify -i` "\n*********************************************"
         set -e
         bundle exec rake test
       """
     }

     stage('Prerelease') {

       if ((env.BRANCH_NAME == "default") && (currentBuild.result == 'SUCCESS')) {                                          

         timeout(time: 5, unit: 'MINUTES') {
           input 'Release to Nexus?'

           sh """#!/bin/bash -l
             echo -e "*********************************************\n** Prereleasing:" `hg identify -i` "\n*********************************************"
             set -e
             bundle exec rake prerelease
           """
         }
       }
     }
  }
}

catch( err ) {
  currentBuild.result = "FAILURE! - ${err}"
  throw err
}

finally {

  println "********************\n** EXECUTING FINALLY BLOCK \n********************\n"

  def buildDuration = Util.getTimeSpanString(System.currentTimeMillis() - currentBuild.startTimeInMillis)

  slackSend message: "${env.JOB_NAME} - #${env.BUILD_NUMBER} ${currentBuild.result} after ${buildDuration} (<${env.BUILD_URL}|Open>)"

  // Remove older build
  properties([[$class: 'BuildDiscarderProperty', strategy: [$class: 'LogRotator', artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '', numToKeepStr: '10']]]);

}

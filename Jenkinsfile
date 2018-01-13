#!groovy

import hudson.Util;

def sendToSlack() {

  def buildDuration = Util.getTimeSpanString(System.currentTimeMillis() - currentBuild.startTimeInMillis)
  def color = 'good'

  if(currentBuild.result != "SUCCESS") {
    color = 'danger'
  }

  slackSend color: color, message: "${env.JOB_NAME} - #${env.BUILD_NUMBER} ${currentBuild.result} after ${buildDuration} (<${env.BUILD_URL}|Open>)"

}

def isNewBuild(name) {
  def current_version = sh(script: """#!/bin/bash -l
    set -e
    rvm use --create . > /dev/null
    rake version
    """,
    returnStdout: true).trim()
  def result = sh(script: """#!/bin/bash -l
    set -e
    rvm use --create . > /dev/null
    gem search ^${name}\$
    """ ,
    returnStdout: true).trim()
  def match = (result =~ /\((.+)\)/)
  if(match) {
    def latest_version = match[0][1]
    println "Comparing current version ${current_version} with published version ${latest_version}."
    return current_version != latest_version
  } else {
    println "No previously published version found."
    return true
  }
}


try {
currentBuild.result = "SUCCESS"

  node('armagh-builder') {

     stage('Prep') {

       deleteDir()

       checkout scm

       sh """#!/bin/bash -l
         echo -e "*********************************************\n** Preparing:" `hg identify -i` "\n*********************************************"
         set -e
         rvm use --create .
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
         rvm use --create .
         bundle exec rake test
       """
     }

     stage('Prerelease') {
       if ((env.BRANCH_NAME == "default") && (currentBuild.result == 'SUCCESS')) {
         if (isNewBuild('armagh_test-custom_actions')) {
           sh """#!/bin/bash -l
             echo -e "*********************************************\n** Prereleasing:" `hg identify -i` "\n*********************************************"
             set -e
             rvm use --create .
             bundle exec rake prerelease
           """
         }
        build job: '/armagh/default', wait: false
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

  sendToSlack()

  // Remove older build
  properties([[$class: 'BuildDiscarderProperty', strategy: [$class: 'LogRotator', artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '', numToKeepStr: '10']]]);

}

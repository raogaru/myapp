// ######################################################################
// Jenkins Job DSL for creating CICD Jobs
// ######################################################################
// View Names
def vViewNameCI="DEMO-CI"
def vViewNameCD="DEMO-CD"
// ######################################################################
// ######################################################################
// CI-PIPELINE JOBS
// ######################################################################
// ######################################################################
job('DEMO-CI-10-Pre-Build') {
	description('DEMO-CI-10-Pre-Build')
	wrappers {
		colorizeOutput() 
		timestamps() 
		preBuildCleanup()
		buildName('#${BUILD_NUMBER}-${PIPE_NUM}')
	}
	logRotator {
		daysToKeep(1)
		numToKeep(24)
	}
	scm { github('raogaru/myapp') }
	steps {
        shell('echo hello')
	}
}
// ######################################################################
job('DEMO-CI-20-Team-Gate') {
	description('DEMO-CI-20-Team-Gate')
	wrappers {
		colorizeOutput() 
		timestamps() 
		buildName('#${BUILD_NUMBER}-${PIPE_NUM}')
	}
	logRotator {
		daysToKeep(1)
		numToKeep(24)
	}
	steps {
        shell('./demo.sh')
	}
}
// ######################################################################
job('DEMO-CI-21-Build-Team-MARS') {
	description('DEMO-CI-21-Build-Team-MARS')
	wrappers {
		colorizeOutput() 
		timestamps() 
		buildName('#${BUILD_NUMBER}-${PIPE_NUM}')
	}
	logRotator {
		daysToKeep(1)
		numToKeep(24)
	}
	steps {
        shell('./demo.sh team mars')
	}
}
// ----------------------------------------------------------------------
job('DEMO-CI-31-Deploy-Team-MARS') {
	description('DEMO-CI-31-Deploy-Team-MARS')
	steps {
        shell('./demo.sh team mars')
	}
}
// ----------------------------------------------------------------------
job('DEMO-CI-41-Test-Team-MARS') {
	description('DEMO-CI-41-Test-Team-MARS')
	steps {
        shell('./demo.sh team mars')
	}
}
// ######################################################################
job('DEMO-CI-22-Build-Team-VENUS') {
	description('DEMO-CI-22-Build-Team-VENUS')
	steps {
        shell('./demo.sh team venus')
	}
}
// ----------------------------------------------------------------------
job('DEMO-CI-32-Deploy-Team-VENUS') {
	description('DEMO-CI-32-Deploy-Team-VENUS')
	steps {
        shell('./demo.sh team venus')
	}
}
// ----------------------------------------------------------------------
job('DEMO-CI-42-Test-Team-VENUS') {
	description('DEMO-CI-42-Test-Team-VENUS')
	steps {
        shell('./demo.sh team venus')
	}
}
// ######################################################################
job('DEMO-CI-23-Build-Team-PLUTO') {
	description('DEMO-CI-23-Build-Team-PLUTO')
	steps {
        shell('./demo.sh team pluto')
	}
}
// ----------------------------------------------------------------------
job('DEMO-CI-33-Deploy-Team-PLUTO') {
	description('DEMO-CI-33-Deploy-Team-PLUTO')
	steps {
        shell('./demo.sh team pluto')
	}
}
// ----------------------------------------------------------------------
job('DEMO-CI-43-Test-Team-PLUTO') {
	description('DEMO-CI-43-Test-Team-PLUTO')
	steps {
        shell('./demo.sh team pluto')
	}
}
// ######################################################################
job('DEMO-CI-50-System-Gate') {
	description('DEMO-CI-50-Build-System-Gate')
	steps {
        shell('echo system gate')
        shell('echo SYSTEM_COMMITS=YES >> /tmp/build.env')
        shell('echo SYSTEM_BUILD=SUCCESS >> /tmp/build.env')
	}
}
// ----------------------------------------------------------------------
job('DEMO-CI-51-Build-System') {
	description('DEMO-CI-51-Build-System')
	steps {
        shell('./demo.sh system')
	}
}
// ----------------------------------------------------------------------
job('DEMO-CI-52-Deploy-System') {
	description('DEMO-CI-52-Deploy-System')
	steps {
        shell('./demo.sh system')
	}
}
// ----------------------------------------------------------------------
job('DEMO-CI-53-Test-System') {
	description('DEMO-CI-53-Test-System')
	steps {
        shell('./demo.sh system')
	}
}
// ######################################################################
job('DEMO-CI-60-Release-Gate') {
	description('DEMO-CI-60-Release-Gate')
	steps {
        shell('echo release gate')
	}
}
// ----------------------------------------------------------------------
job('DEMO-CI-61-Release-Prepare') {
	description('DEMO-CI-61-Release-Prepare')
	steps {
        shell('./demo.sh prepare')
	}
}
// ----------------------------------------------------------------------
job('DEMO-CI-62-Release-Verify') {
	description('DEMO-CI-62-Release-Verify')
	steps {
        shell('./demo.sh verify')
	}
}
// ----------------------------------------------------------------------
job('DEMO-CI-63-Release-Publish') {
	description('DEMO-CI-63-Release-Publish')
	steps {
        shell('./demo.sh publish')
	}
}
// ----------------------------------------------------------------------
job('DEMO-CI-64-Release-Notify') {
	description('DEMO-CI-64-Release-Notify')
	steps {
        shell('./demo.sh notify')
	}
}
// ----------------------------------------------------------------------
// ######################################################################
pipelineJob('DEMO-CI-00-Pipeline') {
  definition {
    cps {
      script('''
pipeline {
	agent any

	options { timestamps() }

	stages {
		stage('Enter') {
			steps {
				build 'DEMO-CI-10-Pre-Build'
				build 'DEMO-CI-20-Team-Gate'
			}
		}
		stage('TeamGate') {
			parallel {
				stage('Team-MARS') {
					steps {
						build 'DEMO-CI-21-Build-Team-MARS'
						build 'DEMO-CI-31-Deploy-Team-MARS'
						build 'DEMO-CI-41-Test-Team-MARS'
					}
				}
				stage('Team-VENUS') {
					steps {
						build 'DEMO-CI-22-Build-Team-VENUS'
						build 'DEMO-CI-32-Deploy-Team-VENUS'
						build 'DEMO-CI-42-Test-Team-VENUS'
					}
				}
				stage('Team-PLUTO') {
					steps {
						build 'DEMO-CI-23-Build-Team-PLUTO'
						build 'DEMO-CI-33-Deploy-Team-PLUTO'
						build 'DEMO-CI-43-Test-Team-PLUTO'
					}
				}
			}
		}
		stage('SystemGate') {
			steps {
				build 'DEMO-CI-50-System-Gate'
				build 'DEMO-CI-51-Build-System'
				build 'DEMO-CI-52-Deploy-System'
				build 'DEMO-CI-53-Test-System'
			}
		}
		stage('ReleaseGate') {
			steps {
				build 'DEMO-CI-60-Release-Gate'
				build 'DEMO-CI-61-Release-Prepare'
				build 'DEMO-CI-62-Release-Verify'
				build 'DEMO-CI-63-Release-Publish'
				build 'DEMO-CI-64-Release-Notify'
			}
		}
	}
}
      '''.stripIndent())
      sandbox()
    }
  }
}
// ######################################################################
// ######################################################################
// CD-PIPELINE JOBS
// ######################################################################
// ######################################################################
job('DEMO-CD-10-Deploy-Security-Test') {
	description('DEMO-CD-10-Deploy-Security-Test')
	scm {github('raogaru/myapp')}
	steps {
        shell('./demo.sh ENV SECURITY')
	}
}
// ######################################################################
job('DEMO-CD-20-Deploy-Performance-Test') {
	description('DEMO-CD-20-Deploy-Performance-Test')
	scm {github('raogaru/myapp')}
	steps {
        shell('./demo.sh ENV PERFORMANCE')
	}
}
// ######################################################################
job('DEMO-CD-30-Deploy-Acceptance-Test') {
	description('DEMO-CD-30-Deploy-Acceptance-Test')
	scm {github('raogaru/myapp')}
	steps {
        shell('./demo.sh ENV ACCEPTANCE')
	}
}
// ######################################################################
job('DEMO-CD-40-Deploy-Interface-Test') {
	description('DEMO-CD-40-Deploy-Interface-Test')
	scm {github('raogaru/myapp')}
	steps {
        shell('./demo.sh ENV INTERFACE')
	}
}
// ######################################################################
job('DEMO-CD-50-Deploy-Production') {
	description('DEMO-CD-50-Deploy-Production')
	scm {github('raogaru/myapp')}
	steps {
        shell('./demo.sh ENV PRODUCTION')
	}
}
// ######################################################################
pipelineJob('DEMO-CD-00-Pipeline') {
  definition {
    cps {
      script('''
pipeline {
    agent any

    options { timestamps() }

    stages {
        stage('Security') {
            steps {
                build 'DEMO-CD-10-Deploy-Security-Test'
            }
        }
        stage('Performance') {
            steps {
                build 'DEMO-CD-20-Deploy-Performance-Test'
            }
        }
        stage('Acceptance') {
            steps {
                build 'DEMO-CD-30-Deploy-Acceptance-Test'
            }
        }
        stage('Interface') {
            steps {
                build 'DEMO-CD-40-Deploy-Interface-Test'
            }
        }
        stage('Production') {
            steps {
                build 'DEMO-CD-50-Deploy-Production'
            }
        }
    }
}
      '''.stripIndent())
      sandbox()
    }
  }
}
// ######################################################################
// ######################################################################
// JENKINS VIEWS
// ######################################################################
// ######################################################################
listView("${vViewNameCI}") {
    description("${vViewNameCI}")
    filterBuildQueue()
    filterExecutors()
    jobs {
        name("${vViewNameCI}")
        regex(/${vViewNameCI}-.+/)
    }
    columns {
        status()
        weather()
        name()
        lastSuccess()
        lastFailure()
        lastDuration()
        buildButton()
    }
}
// ######################################################################
listView("${vViewNameCD}") {
    description("${vViewNameCD}")
    filterBuildQueue()
    filterExecutors()
    jobs {
        name("${vViewNameCD}")
        regex(/${vViewNameCD}-.+/)
    }
    columns {
        status()
        weather()
        name()
        lastSuccess()
        lastFailure()
        lastDuration()
        buildButton()
    }
}
// ######################################################################
buildPipelineView("${vViewNameCI}-Pipe") {
    filterBuildQueue()
    filterExecutors()
    title("${vViewNameCI}-Pipeline")
    displayedBuilds(5)
    selectedJob('DEMO-CI-00-Pipeline')
    alwaysAllowManualTrigger()
    showPipelineParameters()
    refreshFrequency(60)
}
// ######################################################################

// ######################################################################
// Jenkins Job DSL for creating CICD Jobs
// ######################################################################
// View Names
def vViewNameCI="RAO-CI"
def vViewNameCD="RAO-CD"
// ######################################################################
// ######################################################################
// CI-PIPELINE JOBS
// ######################################################################
// ######################################################################
job('RAO-CI-10-Pre-Build') {
	description('RAO-CI-10-Pre-Build')
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
	steps {
        shell('echo hello')
	}
}
// ######################################################################
job('RAO-CI-20-Team-Gate') {
	description('RAO-CI-20-Team-Gate')
	wrappers {
		colorizeOutput() 
		timestamps() 
		buildName('#${BUILD_NUMBER}-${PIPE_NUM}')
	}
	logRotator {
		daysToKeep(1)
		numToKeep(24)
	}
	scm {github('raogaru/myapp')}
	steps {
        shell('./TeamGate.sh')
	}
}
// ######################################################################
job('RAO-CI-21-Build-Team-MARS') {
	description('RAO-CI-21-Build-Team-MARS')
	wrappers {
		colorizeOutput() 
		timestamps() 
		buildName('#${BUILD_NUMBER}-${PIPE_NUM}')
	}
	logRotator {
		daysToKeep(1)
		numToKeep(24)
	}
	scm {github('raogaru/myapp')}
	steps {
        shell('./build.sh team mars')
	}
}
// ----------------------------------------------------------------------
job('RAO-CI-31-Deploy-Team-MARS') {
	description('RAO-CI-31-Deploy-Team-MARS')
	scm {github('raogaru/myapp')}
	steps {
        shell('./deploy.sh team mars')
	}
}
// ----------------------------------------------------------------------
job('RAO-CI-41-Test-Team-MARS') {
	description('RAO-CI-41-Test-Team-MARS')
	scm {github('raogaru/myapp')}
	steps {
        shell('./test.sh team mars')
	}
}
// ######################################################################
job('RAO-CI-22-Build-Team-VENUS') {
	description('RAO-CI-22-Build-Team-VENUS')
	scm {github('raogaru/myapp')}
	steps {
        shell('./build.sh team venus')
	}
}
// ----------------------------------------------------------------------
job('RAO-CI-32-Deploy-Team-VENUS') {
	description('RAO-CI-32-Deploy-Team-VENUS')
	scm {github('raogaru/myapp')}
	steps {
        shell('./deploy.sh team venus')
	}
}
// ----------------------------------------------------------------------
job('RAO-CI-42-Test-Team-VENUS') {
	description('RAO-CI-42-Test-Team-VENUS')
	scm {github('raogaru/myapp')}
	steps {
        shell('./test.sh team venus')
	}
}
// ######################################################################
job('RAO-CI-23-Build-Team-PLUTO') {
	description('RAO-CI-23-Build-Team-PLUTO')
	scm {github('raogaru/myapp')}
	steps {
        shell('./build.sh team pluto')
	}
}
// ----------------------------------------------------------------------
job('RAO-CI-33-Deploy-Team-PLUTO') {
	description('RAO-CI-33-Deploy-Team-PLUTO')
	scm {github('raogaru/myapp')}
	steps {
        shell('./deploy.sh team pluto')
	}
}
// ----------------------------------------------------------------------
job('RAO-CI-43-Test-Team-PLUTO') {
	description('RAO-CI-43-Test-Team-PLUTO')
	scm {github('raogaru/myapp')}
	steps {
        shell('./test.sh team pluto')
	}
}
// ######################################################################
job('RAO-CI-50-System-Gate') {
	description('RAO-CI-50-Build-System-Gate')
	steps {
        shell('echo system gate')
        shell('echo SYSTEM_COMMITS=YES >> /tmp/build.env')
        shell('echo SYSTEM_BUILD=SUCCESS >> /tmp/build.env')
	}
}
// ----------------------------------------------------------------------
job('RAO-CI-51-Build-System') {
	description('RAO-CI-51-Build-System')
	scm {github('raogaru/myapp')}
	steps {
        shell('./build.sh system')
	}
}
// ----------------------------------------------------------------------
job('RAO-CI-52-Deploy-System') {
	description('RAO-CI-52-Deploy-System')
	scm {github('raogaru/myapp')}
	steps {
        shell('./deploy.sh system')
	}
}
// ----------------------------------------------------------------------
job('RAO-CI-53-Test-System') {
	description('RAO-CI-53-Test-System')
	scm {github('raogaru/myapp')}
	steps {
        shell('./test.sh system')
	}
}
// ######################################################################
job('RAO-CI-60-Release-Gate') {
	description('RAO-CI-60-Release-Gate')
	scm {github('raogaru/myapp')}
	steps {
        shell('echo release gate')
	}
}
// ----------------------------------------------------------------------
job('RAO-CI-61-Release-Prepare') {
	description('RAO-CI-61-Release-Prepare')
	scm {github('raogaru/myapp')}
	steps {
        shell('./release.sh prepare')
	}
}
// ----------------------------------------------------------------------
job('RAO-CI-62-Release-Verify') {
	description('RAO-CI-62-Release-Verify')
	scm {github('raogaru/myapp')}
	steps {
        shell('./release.sh verify')
	}
}
// ----------------------------------------------------------------------
job('RAO-CI-63-Release-Publish') {
	description('RAO-CI-63-Release-Publish')
	scm {github('raogaru/myapp')}
	steps {
        shell('./release.sh publish')
	}
}
// ----------------------------------------------------------------------
job('RAO-CI-64-Release-Notify') {
	description('RAO-CI-64-Release-Notify')
	scm {github('raogaru/myapp')}
	steps {
        shell('./release.sh notify')
	}
}
// ----------------------------------------------------------------------
// ######################################################################
pipelineJob('RAO-CI-00-Pipeline') {
  definition {
    cps {
      script('''
pipeline {
	agent any

	options { timestamps() }

	stages {
		stage('Enter') {
			steps {
				build 'RAO-CI-10-Pre-Build'
				build 'RAO-CI-20-Team-Gate'
			}
		}
		stage('TeamGate') {
			parallel {
				stage('Team-MARS') {
					steps {
						build 'RAO-CI-21-Build-Team-MARS'
						build 'RAO-CI-31-Deploy-Team-MARS'
						build 'RAO-CI-41-Test-Team-MARS'
					}
				}
				stage('Team-VENUS') {
					steps {
						build 'RAO-CI-22-Build-Team-VENUS'
						build 'RAO-CI-32-Deploy-Team-VENUS'
						build 'RAO-CI-42-Test-Team-VENUS'
					}
				}
				stage('Team-PLUTO') {
					steps {
						build 'RAO-CI-23-Build-Team-PLUTO'
						build 'RAO-CI-33-Deploy-Team-PLUTO'
						build 'RAO-CI-43-Test-Team-PLUTO'
					}
				}
			}
		}
		stage('SystemGate') {
			steps {
				build 'RAO-CI-50-System-Gate'
				build 'RAO-CI-51-Build-System'
				build 'RAO-CI-52-Deploy-System'
				build 'RAO-CI-53-Test-System'
			}
		}
		stage('ReleaseGate') {
			steps {
				build 'RAO-CI-60-Release-Gate'
				build 'RAO-CI-61-Release-Prepare'
				build 'RAO-CI-62-Release-Verify'
				build 'RAO-CI-63-Release-Publish'
				build 'RAO-CI-64-Release-Notify'
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
job('RAO-CD-10-Deploy-Security-Test') {
	description('RAO-CD-10-Deploy-Security-Test')
	scm {github('raogaru/myapp')}
	steps {
        shell('./deploy.sh ENV SECURITY')
	}
}
// ######################################################################
job('RAO-CD-20-Deploy-Performance-Test') {
	description('RAO-CD-20-Deploy-Performance-Test')
	scm {github('raogaru/myapp')}
	steps {
        shell('./deploy.sh ENV PERFORMANCE')
	}
}
// ######################################################################
job('RAO-CD-30-Deploy-Acceptance-Test') {
	description('RAO-CD-30-Deploy-Acceptance-Test')
	scm {github('raogaru/myapp')}
	steps {
        shell('./deploy.sh ENV ACCEPTANCE')
	}
}
// ######################################################################
job('RAO-CD-40-Deploy-Interface-Test') {
	description('RAO-CD-40-Deploy-Interface-Test')
	scm {github('raogaru/myapp')}
	steps {
        shell('./deploy.sh ENV INTERFACE')
	}
}
// ######################################################################
job('RAO-CD-50-Deploy-Production') {
	description('RAO-CD-50-Deploy-Production')
	scm {github('raogaru/myapp')}
	steps {
        shell('./deploy.sh ENV PRODUCTION')
	}
}
// ######################################################################
pipelineJob('RAO-CD-00-Pipeline') {
  definition {
    cps {
      script('''
pipeline {
    agent any

    options { timestamps() }

    stages {
        stage('Security') {
            steps {
                build 'RAO-CD-10-Deploy-Security-Test'
            }
        }
        stage('Performance') {
            steps {
                build 'RAO-CD-20-Deploy-Performance-Test'
            }
        }
        stage('Acceptance') {
            steps {
                build 'RAO-CD-30-Deploy-Acceptance-Test'
            }
        }
        stage('Interface') {
            steps {
                build 'RAO-CD-40-Deploy-Interface-Test'
            }
        }
        stage('Production') {
            steps {
                build 'RAO-CD-50-Deploy-Production'
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
    selectedJob('RAO-CI-00-Pipeline')
    alwaysAllowManualTrigger()
    showPipelineParameters()
    refreshFrequency(60)
}
// ######################################################################

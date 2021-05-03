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
job('RAO-CI-10-Enter-Build') {
	description('RAO-CI-10-Enter-Build')
	scm {github('raogaru/myapp')}
	steps {
        shell('./flow.sh')
	}
}
// ######################################################################
job('RAO-CI-20-Build-Team-MARS') {
	description('RAO-CI-20-Build-Team-MARS')
	scm {github('raogaru/myapp')}
	steps {
        shell('./build.sh team mars')
	}
}
// ######################################################################
job('RAO-CI-20-Build-Team-VENUS') {
	description('RAO-CI-20-Build-Team-VENUS')
	scm {github('raogaru/myapp')}
	steps {
        shell('./build.sh team venus')
	}
}
// ######################################################################
job('RAO-CI-20-Build-Team-PLUTO') {
	description('RAO-CI-20-Build-Team-PLUTO')
	scm {github('raogaru/myapp')}
	steps {
        shell('./build.sh team pluto')
	}
}
// ######################################################################
job('RAO-CI-30-Deploy-Team-MARS') {
	description('RAO-CI-50-Deploy-Team-MARS')
	scm {github('raogaru/myapp')}
	steps {
        shell('./deploy.sh team mars')
	}
}
// ######################################################################
job('RAO-CI-30-Deploy-Team-VENUS') {
	description('RAO-CI-50-Deploy-Team-VENUS')
	scm {github('raogaru/myapp')}
	steps {
        shell('./deploy.sh team venus')
	}
}
// ######################################################################
job('RAO-CI-30-Deploy-Team-PLUTO') {
	description('RAO-CI-50-Deploy-Team-PLUTO')
	scm {github('raogaru/myapp')}
	steps {
        shell('./deploy.sh team pluto')
	}
}
// ######################################################################
job('RAO-CI-40-Test-Team-MARS') {
	description('RAO-CI-40-Test-Team-MARS')
	scm {github('raogaru/myapp')}
	steps {
        shell('./test.sh team mars')
	}
}
// ######################################################################
job('RAO-CI-40-Test-Team-VENUS') {
	description('RAO-CI-40-Test-Team-VENUS')
	scm {github('raogaru/myapp')}
	steps {
        shell('./test.sh team venus')
	}
}
// ######################################################################
job('RAO-CI-40-Test-Team-PLUTO') {
	description('RAO-CI-40-Test-Team-PLUTO')
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

    options {
        timestamps()
    }

    stages {
        stage('Enter') {
            steps {
                build 'RAO-CI-10-Enter-Build'
            }
        }
        stage('Team') {
	    parallel {
	    stage('Team-MARS') {
            steps {
                build 'RAO-CI-20-Build-Team-MARS'
                build 'RAO-CI-30-Deploy-Team-MARS'
                build 'RAO-CI-40-Test-Team-MARS'
            }
	    }
	    stage('Team-VENUS') {
            steps {
                build 'RAO-CI-20-Build-Team-VENUS'
                build 'RAO-CI-30-Deploy-Team-VENUS'
                build 'RAO-CI-40-Test-Team-VENUS'
            }
	    }
	    stage('Team-PLUTO') {
            steps {
                build 'RAO-CI-20-Build-Team-PLUTO'
                build 'RAO-CI-30-Deploy-Team-PLUTO'
                build 'RAO-CI-40-Test-Team-PLUTO'
            }
            }
	    }
        }
        stage('System') {
            steps {
                build 'RAO-CI-50-System-Gate'
                build 'RAO-CI-51-Build-System'
                build 'RAO-CI-52-Deploy-System'
                build 'RAO-CI-53-Test-System'
            }
        }
        stage('Release') {
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
        shell('./deploy.sh SECURITY')
	}
}
// ######################################################################
job('RAO-CD-20-Deploy-Performance-Test') {
	description('RAO-CD-20-Deploy-Performance-Test')
	scm {github('raogaru/myapp')}
	steps {
        shell('./deploy.sh PERFORMANCE')
	}
}
// ######################################################################
job('RAO-CD-30-Deploy-Acceptance-Test') {
	description('RAO-CD-30-Deploy-Acceptance-Test')
	scm {github('raogaru/myapp')}
	steps {
        shell('./deploy.sh ACCEPTANCE')
	}
}
// ######################################################################
job('RAO-CD-40-Deploy-Interface-Test') {
	description('RAO-CD-40-Deploy-Interface-Test')
	scm {github('raogaru/myapp')}
	steps {
        shell('./deploy.sh INTERFACE')
	}
}
// ######################################################################
job('RAO-CD-50-Deploy-Production') {
	description('RAO-CD-50-Deploy-Production')
	scm {github('raogaru/myapp')}
	steps {
        shell('./deploy.sh PRODUCTION')
	}
}
// ######################################################################
pipelineJob('RAO-CD-00-Pipeline') {
  definition {
    cps {
      script('''
pipeline {
    agent any

    options {
        timestamps()
    }

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

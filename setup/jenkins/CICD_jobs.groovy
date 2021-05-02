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
job('RAO-CI-20-Team-Build-MARS') {
	description('RAO-CI-20-Team-Build-MARS')
	scm {github('raogaru/myapp')}
	steps {
        shell('./build.sh team mars')
	}
}
// ######################################################################
job('RAO-CI-20-Team-Build-VENUS') {
	description('RAO-CI-20-Team-Build-VENUS')
	scm {github('raogaru/myapp')}
	steps {
        shell('./build.sh team venus')
	}
}
// ######################################################################
job('RAO-CI-20-Team-Build-PLUTO') {
	description('RAO-CI-20-Team-Build-PLUTO')
	scm {github('raogaru/myapp')}
	steps {
        shell('./build.sh team pluto')
	}
}
// ######################################################################
job('RAO-CI-30-System-Build') {
	description('RAO-CI-30-System-Build')
	scm {github('raogaru/myapp')}
	steps {
        shell('./build.sh system')
	}
}
// ######################################################################
job('RAO-CI-40-Release-Build') {
	description('RAO-CI-40-Release-Build')
	scm {github('raogaru/myapp')}
	steps {
        shell('./build.sh release')
	}
}
// ######################################################################
job('RAO-CI-50-Deploy-Pipeline-Test') {
	description('RAO-CI-50-Deploy-Pipeline-Test')
	scm {github('raogaru/myapp')}
	steps {
        shell('./deploy.sh PIPE')
	}
}
// ######################################################################
job('RAO-CI-55-Execute-Pipeline-Test') {
	description('RAO-CI-55-Execute-Pipeline-Test')
	scm {github('raogaru/myapp')}
	steps {
        shell('./test.sh PIPE')
	}
} 
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
            steps {
                parallel
		(
                build 'RAO-CI-20-Team-Build-MARS'
                build 'RAO-CI-20-Team-Build-VENUS'
                build 'RAO-CI-20-Team-Build-PLUTO'
		)
            }
        }
        stage('System') {
            steps {
                build 'RAO-CI-30-System-Build'
            }
        }
        stage('Release') {
            steps {
                build 'RAO-CI-40-Release-Build'
            }
        }
        stage('Deploy') {
            steps {
                build 'RAO-CI-50-Deploy-Pipeline-Test'
            }
        }
        stage('Test') {
            steps {
                build 'RAO-CI-55-Execute-Pipeline-Test'
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

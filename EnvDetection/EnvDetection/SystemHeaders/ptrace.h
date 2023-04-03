//
//  ptrace.h
//  EnvDetection
//
//  Created by 小七 on 2023/4/3.
//

#ifndef ptrace_h
#define ptrace_h

#include <sys/appleapiopts.h>
#include <sys/cdefs.h>
#include <sys/types.h>

enum {
    ePtAttachDeprecated __deprecated_enum_msg("PT_ATTACH is deprecated. See PT_ATTACHEXC") = 10
};


#define PT_TRACE_ME     0       /* child declares it's being traced */
#define PT_READ_I       1       /* read word in child's I space */
#define PT_READ_D       2       /* read word in child's D space */
#define PT_READ_U       3       /* read word in child's user structure */
#define PT_WRITE_I      4       /* write word in child's I space */
#define PT_WRITE_D      5       /* write word in child's D space */
#define PT_WRITE_U      6       /* write word in child's user structure */
#define PT_CONTINUE     7       /* continue the child */
#define PT_KILL         8       /* kill the child process */
#define PT_STEP         9       /* single step the child */
#define PT_ATTACH       ePtAttachDeprecated     /* trace some running process */
#define PT_DETACH       11      /* stop tracing a process */
#define PT_SIGEXC       12      /* signals as exceptions for current_proc */
#define PT_THUPDATE     13      /* signal for thread# */
#define PT_ATTACHEXC    14      /* attach to running process with signal exception */

#define PT_FORCEQUOTA   30      /* Enforce quota for root */
#define PT_DENY_ATTACH  31

#define PT_FIRSTMACH    32      /* for machine-specific requests */

__BEGIN_DECLS


int     ptrace(int _request, pid_t _pid, caddr_t _addr, int _data);


__END_DECLS

#endif /* ptrace_h */

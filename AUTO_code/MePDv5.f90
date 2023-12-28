!---------------------------------------------------------------------- 
!---------------------------------------------------------------------- 
!    MePD model based on Wilson-Cowan framework
!---------------------------------------------------------------------- 
!---------------------------------------------------------------------- 

      SUBROUTINE FUNC(NDIM,U,ICP,PAR,IJAC,F,DFDU,DFDP) 
!     ---------- ---- 

      IMPLICIT NONE
      INTEGER, INTENT(IN) :: NDIM, ICP(*), IJAC
      DOUBLE PRECISION, INTENT(IN) :: U(NDIM), PAR(*)
      DOUBLE PRECISION, INTENT(OUT) :: F(NDIM)
      DOUBLE PRECISION, INTENT(INOUT) :: DFDU(NDIM,NDIM), DFDP(NDIM,*)
      
      DOUBLE PRECISION Gl, Gi, Ge, Kp, alpha, ae, thetae, ai, thetai, cll, cil, cli, cle, cie, Fl, Fi, Fe, beta1, beta2

      Gl=U(1)
      Gi=U(2)
      Ge=U(3)
      
      Kp=PAR(1)
      alpha=PAR(2)
      ae=1.3
      thetae=4
      ai=2
      thetai=3.7
      cll=PAR(7)
      cil=PAR(3)
      cli=PAR(4)
      cle=40
      cie=25
      beta1=PAR(5)
      beta2=PAR(6)
      
      Fl=(1-beta2)*cll*Gl-(1-beta1)*cil*Gi+Kp*alpha
      Fi=(1-beta2)*cli*Gl+Kp*(1-alpha)
      Fe=(1-beta2)*cle*Gl-(1-beta1)*cie*Gi
      F(1) = -Gl + (1-1*Gl)*(1/(1+exp(-ae*(Fl-thetae)))-1/(1+exp(ae*thetae)))
      F(2) = -Gi + (1-1*Gi)*(1/(1+exp(-ai*(Fi-thetai)))-1/(1+exp(ai*thetai)))
      F(3) = -Ge + (1-1*Ge)*(1/(1+exp(-ai*(Fe-thetai)))-1/(1+exp(ai*thetai)))
      
      
      END SUBROUTINE FUNC

      SUBROUTINE STPNT(NDIM,U,PAR,T)
      !     ----------------
      IMPLICIT NONE
      INTEGER, INTENT(IN) :: NDIM
      DOUBLE PRECISION, INTENT(INOUT) :: U(NDIM),PAR(*)
      DOUBLE PRECISION, INTENT(IN) :: T

       PAR(1)=0!Kp
       PAR(2)=0.9!alpha
       PAR(3)=35!cil
       PAR(4)=16!cli
       PAR(5)=0!beta1 (GABA antag)
       PAR(6)=0!beta2 (Glutamate  antag)
       PAR(7)=18 !cll
       
       U(1)=0.
       U(2)=0.
       U(3)=0.
       
       
       END SUBROUTINE STPNT

      SUBROUTINE BCND 
      END SUBROUTINE BCND

      SUBROUTINE ICND 
      END SUBROUTINE ICND

      SUBROUTINE FOPT 
      END SUBROUTINE FOPT
      SUBROUTINE PVLS(NDIM,U,PAR)
      IMPLICIT NONE
      INTEGER, INTENT(IN) :: NDIM
      DOUBLE PRECISION, INTENT(IN) :: U(NDIM)
      DOUBLE PRECISION, INTENT(INOUT) :: PAR(*)

      DOUBLE PRECISION, EXTERNAL :: GETP,GETU2
      INTEGER NDX,NCOL,NTST
      PAR(8)=GETP('MIN',1,U)
      PAR(9)=GETP('MIN',3,U)
      PAR(10)=GETP('STA',0,U)

    
     
      END SUBROUTINE PVLS
      
      
      
      

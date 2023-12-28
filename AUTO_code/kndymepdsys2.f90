!---------------------------------------------------------------------- 
!---------------------------------------------------------------------- 
!           KNDy+MePD
!---------------------------------------------------------------------- 
!---------------------------------------------------------------------- 

SUBROUTINE FUNC(NDIM,U,ICP,PAR,IJAC,F,DFDU,DFDP) 
!     ---------- ---- 

      IMPLICIT NONE
      INTEGER, INTENT(IN) :: NDIM, ICP(*), IJAC
      DOUBLE PRECISION, INTENT(IN) :: U(NDIM), PAR(*)
      DOUBLE PRECISION, INTENT(OUT) :: F(NDIM)
      DOUBLE PRECISION, INTENT(INOUT) :: DFDU(NDIM,NDIM), DFDP(NDIM,*)
      
      DOUBLE PRECISION Dyn, NKB, v,&
       d1, d2, d3, k1, k2, k01, k02, pr, v0, KD, KN,&
       Kr1, Kr2, I0,I, Im, Gl, Gi, Ge, Kp, alpha, ae, &
       thetae, ai, thetai, cll, cil, cli, cle, cie,&
        Fl, Fi, Fe,d, jl, je
        
      Gl=U(1)
      Gi=U(2)
      Ge=U(3)
      v=U(4)
      NKB=U(5)
      Dyn=U(6)
 
      
      d1 =0.25 ! Dyn degradation rate
      d2 =1! NKB degradation rate 
      d3 =10  ! Firing rate reset rate 
      k1 =4 ! Maximum Dyn secretion rate
      k2 =40  ! Maximum NKB secretion rate
      k01 =0 ! Basal Dyn secretion rate 
      k02 =0.0 ! Basal NKB secretion rate 
      pr =0.006 ! Effective strength of synaptic input
      v0 =25000  ! Maximum rate of neuronal activity increase 
      KD =0.3  ! Dyn IC50
      KN =4 ! NKB EC50
      Kr1 =600 ! Firing rate for half-maximal Dyn secretion  
      Kr2 =200! Firing rate for half-maximal NKB secretion
      
      
      ae=1.3
      thetae=4
      ai=2
      thetai=3.7
      cll=18
      cil=35
      cli=16
      cle=40
      cie=25
      alpha = 0.9
      d=3
      
      I0 = PAR(1)  ! Basal activity
      Kp = PAR(2)
      jl = PAR(3)
      je = PAR(4)
      
      
      
      Fl=cll*Gl-cil*Gi+Kp*alpha
      Fi=cli*Gl+Kp*(1-alpha)
      Fe=cle*Gl-cie*Gi
      F(1) = d*(-Gl + (1-1*Gl)*(1/(1+exp(-ae*(Fl-thetae)))-1/(1+exp(ae*thetae))))
      F(2) = d*(-Gi + (1-1*Gi)*(1/(1+exp(-ai*(Fi-thetai)))-1/(1+exp(ai*thetai))))
      F(3) = d*(-Ge + (1-1*Ge)*(1/(1+exp(-ai*(Fe-thetai)))-1/(1+exp(ai*thetai))))

      Im= Gl*jl-Ge*je
      I = I0 + pr*NKB**2*v/(NKB**2+KN**2)+Im
      
      
      F(4) = v0*(1/(1+exp(10*(-I+0.5))))-d3*v 
      F(5) = k02 + k2*v**2/(v**2+(Kr2)**2)*KD**2/(Dyn**2+KD**2)-d2*NKB
      F(6) = k01 + k1*v**2/(v**2+(Kr1)**2)-Dyn*d1     
      

      END SUBROUTINE FUNC
      
      SUBROUTINE STPNT(NDIM,U,PAR,T)
      !     ----------------


      IMPLICIT NONE
      INTEGER, INTENT(IN) :: NDIM
      DOUBLE PRECISION, INTENT(INOUT) :: U(NDIM),PAR(*)
      DOUBLE PRECISION, INTENT(IN) :: T


       PAR(1)=-200!I0
       PAR(2)=0 !Kp
       PAR(4)=0.5
       PAR(3)=1.5
       
       U(1)=0
       U(2)=0.
       U(3)=0.
       U(4)=0
       U(5)=0
       U(6)=0


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
      PAR(5)=GETP('STA',0,U)
      PAR(6)=GETP('MIN',1,U)
      PAR(7)=GETP('MIN',3,U)
      PAR(8)=GETP('MAX',1,U)
      PAR(9)=GETP('MAX',3,U)
    
      
 
     
      END SUBROUTINE PVLS

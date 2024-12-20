<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="false" %>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Dashboard - SB Admin</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <link href="<c:url value='/resources/css/styles.css'/>" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    </head>
    <body class="sb-nav-fixed">
        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
            <!-- Navbar Brand-->
            <a class="navbar-brand ps-3" href="index.html">자재 관리</a>
            <!-- Sidebar Toggle-->
            <button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle" href="#!"><i class="fas fa-bars"></i></button>
            <!-- Navbar Search-->
            <form class="d-none d-md-inline-block form-inline ms-auto me-0 me-md-3 my-2 my-md-0">
                <div class="input-group">
                    <input class="form-control" type="text" placeholder="Search for..." aria-label="Search for..." aria-describedby="btnNavbarSearch" />
                    <button class="btn btn-primary" id="btnNavbarSearch" type="button"><i class="fas fa-search"></i></button>
                </div>
            </form>
            <!-- Navbar-->
            <ul class="navbar-nav ms-auto ms-md-0 me-3 me-lg-4">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false"><i class="fas fa-user fa-fw"></i></a>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                        <li><a class="dropdown-item" href="#!">Settings</a></li>
                        <li><a class="dropdown-item" href="#!">Activity Log</a></li>
                        <li><hr class="dropdown-divider" /></li>
                        <li><a class="dropdown-item" href="#!">Logout</a></li>
                    </ul>
                </li>
            </ul>
        </nav>
        <div id="layoutSidenav">
            <div id="layoutSidenav_nav">
                <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
                    <div class="sb-sidenav-menu">
                        <div class="nav">
                            <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseMitsumorisho" aria-expanded="false" aria-controls="collapseMitsumorisho">
                                견적서
                                <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                            </a>
                            <div class="collapse" id="collapseMitsumorisho" aria-labelledby="headingOne" data-bs-parent="#sidenavAccordion">
                                <nav class="sb-sidenav-menu-nested nav">
                                    <a class="nav-link" href="mitsumorisho-query.html">견적서조회</a>
                                    <a class="nav-link" href="mitsumorisho-input.html">견적서입력</a>
                                    <a class="nav-link" href="mitsumorisho-status.html">견적서현황</a>
                                    <a class="nav-link" href="mitsumorisho-unordered.html">미주문현황</a>
                                </nav>
                            </div>
                            <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseJumunsho" aria-expanded="false" aria-controls="collapseJumunsho">
                                주문서
                                <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                            </a>
                            <div class="collapse" id="collapseJumunsho" aria-labelledby="headingTwo" data-bs-parent="#sidenavAccordion">
                                <nav class="sb-sidenav-menu-nested nav">
                                    <a class="nav-link" href="jumunsho-query.html">주문서조회</a>
                                    <a class="nav-link" href="jumunsho-input.html">주문서입력</a>
                                    <a class="nav-link" href="jumunsho-status.html">주문서현황</a>
                                    <a class="nav-link" href="jumunsho-process.html">주문서출고처리</a>
                                    <a class="nav-link" href="jumunsho-unsold.html">미판매현황</a>
                                </nav>
                            </div>
                            <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseHanbai" aria-expanded="false" aria-controls="collapseHanbai">
                                판매
                                <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                            </a>
                            <div class="collapse" id="collapseHanbai" aria-labelledby="headingThree" data-bs-parent="#sidenavAccordion">
                                <nav class="sb-sidenav-menu-nested nav">
                                    <a class="nav-link" href="hanbai-query.html">판매조회</a>
                                    <a class="nav-link" href="hanbai-input.html">판매입력</a>
                                    <a class="nav-link" href="hanbai-input2.html">판매입력II</a>
                                    <a class="nav-link" href="hanbai-price.html">판매단가일괄변경</a>
                                    <a class="nav-link" href="hanbai-status.html">판매현황</a>
                                    <a class="nav-link" href="hanbai-payment-query.html">결제내역조회</a>
                                    <a class="nav-link" href="hanbai-payment-compare.html">결제내역자료비교</a>
                                </nav>
                            </div>
                             <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseShukkaSiji" aria-expanded="false" aria-controls="collapseHanbai">
                                출하지시서
                                <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                            </a>
                            <div class="collapse" id="collapseShukkaSiji" aria-labelledby="headingFour" data-bs-parent="#sidenavAccordion">
                                <nav class="sb-sidenav-menu-nested nav">
                                    <a class="nav-link" href="hanbai-query.html">출하지시서조회</a>
                                    <a class="nav-link" href="hanbai-input.html">출하지시서입력</a>
                                    <a class="nav-link" href="hanbai-input2.html">출하지시서현황</a>
                                </nav>
                            </div>
                             <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseShukka" aria-expanded="false" aria-controls="collapseHanbai">
                                출하
                                <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                            </a>
                            <div class="collapse" id="collapseShukka" aria-labelledby="headingFive" data-bs-parent="#sidenavAccordion">
                                <nav class="sb-sidenav-menu-nested nav">
                                    <a class="nav-link" href="hanbai-query.html">출하조회</a>
                                    <a class="nav-link" href="hanbai-input.html">출하입력</a>
                                    <a class="nav-link" href="hanbai-input2.html">출하현황</a>
                                </nav>
                            </div>
                            
                        </div>
                    </div>
                    <div class="sb-sidenav-footer">
                        <div class="small">Logged in as:</div>
                        OOO 사원님
                    </div>
                </nav>
            </div>
            <div id="layoutSidenav_content">
            <!-- header 끝 -->
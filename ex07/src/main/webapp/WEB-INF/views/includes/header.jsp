<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page session="false" %>
<html lang="ja">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>ダッシュボード - SB Admin</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <link href="<c:url value='/resources/css/styles.css'/>" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    </head>
    <body class="sb-nav-fixed">
        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
            <!-- ナビゲーションバーのブランド -->
            <a class="navbar-brand ps-3" href="/">資材管理</a>
            <!-- サイドバートグル -->
            <button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle" href="#!"><i class="fas fa-bars"></i></button>
            <!-- ナビゲーションバーの検索 -->
            <form class="d-none d-md-inline-block form-inline ms-auto me-0 me-md-3 my-2 my-md-0">
                <div class="input-group">
                    <input class="form-control" type="text" placeholder="検索..." aria-label="検索..." aria-describedby="btnNavbarSearch" />
                    <button class="btn btn-primary" id="btnNavbarSearch" type="button"><i class="fas fa-search"></i></button>
                </div>
            </form>
            <!-- ナビゲーションバー -->
            <ul class="navbar-nav ms-auto ms-md-0 me-3 me-lg-4">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false"><i class="fas fa-user fa-fw"></i></a>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                        <li><a class="dropdown-item" href="#!">設定</a></li>
                        <li><a class="dropdown-item" href="#!">活動ログ</a></li>
                        <li><hr class="dropdown-divider" /></li>
                        <li><a class="dropdown-item" href="#!">ログアウト</a></li>
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
                                見積書
                                <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                            </a>
                            <div class="collapse" id="collapseMitsumorisho" aria-labelledby="headingOne" data-bs-parent="#sidenavAccordion">
                                <nav class="sb-sidenav-menu-nested nav">
                                    <a class="nav-link" href="/estimate/list">見積書照会</a>
                                    <a class="nav-link" href="/estimate/input">見積書入力</a>
                                    <a class="nav-link" href="/estimate/status">見積書現況</a>
                                    <a class="nav-link" href="/estimate/unordered">未注文現況</a>
                                </nav>
                            </div>
                            <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseJumunsho" aria-expanded="false" aria-controls="collapseJumunsho">
                                注文書
                                <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                            </a>
                            <div class="collapse" id="collapseJumunsho" aria-labelledby="headingTwo" data-bs-parent="#sidenavAccordion">
                                <nav class="sb-sidenav-menu-nested nav">
                                    <a class="nav-link" href="/order/list">注文書照会</a>
                                    <a class="nav-link" href="/order/input">注文書入力</a>
                                    <a class="nav-link" href="/order/status">注文書現況</a>
                                    <a class="nav-link" href="/order/release">注文書出庫処理</a>
                                    <a class="nav-link" href="/order/unsold">未販売現況</a>
                                </nav>
                            </div>
                            <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseHanbai" aria-expanded="false" aria-controls="collapseHanbai">
                                販売
                                <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                            </a>
                            <div class="collapse" id="collapseHanbai" aria-labelledby="headingThree" data-bs-parent="#sidenavAccordion">
                                <nav class="sb-sidenav-menu-nested nav">
                                    <a class="nav-link" href="/sale/list">販売照会</a>
                                    <a class="nav-link" href="/sale/input">販売入力</a>
                                    <a class="nav-link" href="/sale/input2">販売入力II</a>
                                    <a class="nav-link" href="/sale/price">販売単価一括変更</a>
                                    <a class="nav-link" href="/sale/status">販売現況</a>
                                    <a class="nav-link" href="/sale/payment_query">決済履歴照会</a>
                                    <a class="nav-link" href="/sale/payment_compare">決済履歴資料比較</a>
                                </nav>
                            </div>
                             <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseShukkaSiji" aria-expanded="false" aria-controls="collapseHanbai">
                                出荷指示書
                                <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                            </a>
                            <div class="collapse" id="collapseShukkaSiji" aria-labelledby="headingFour" data-bs-parent="#sidenavAccordion">
                                <nav class="sb-sidenav-menu-nested nav">
                                    <a class="nav-link" href="/shipment/list">出荷指示書照会</a>
                                    <a class="nav-link" href="/shipment/input">出荷指示書入力</a>
                                    <a class="nav-link" href="/shipment/status">出荷指示書現況</a>
                                </nav>
                            </div>
                             <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseShukka" aria-expanded="false" aria-controls="collapseHanbai">
                                出荷
                                <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                            </a>
                            <div class="collapse" id="collapseShukka" aria-labelledby="headingFive" data-bs-parent="#sidenavAccordion">
                                <nav class="sb-sidenav-menu-nested nav">
                                    <a class="nav-link" href="/delivery/list">出荷照会</a>
                                    <a class="nav-link" href="/delivery/input">出荷入力</a>
                                    <a class="nav-link" href="/delivery/status">出荷現況</a>
                                </nav>
                            </div>
                            
                        </div>
                    </div>
                    <div class="sb-sidenav-footer">
                        <div class="small">ログイン中:</div>
                        OOO 社員様
                    </div>
                </nav>
            </div>
            <div id="layoutSidenav_content">
            <!-- header 終了 -->

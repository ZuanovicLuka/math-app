package math.backend.config;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;
import java.io.IOException;

@Component
public class JwtAuthenticationFilter extends OncePerRequestFilter {

    private final JwtService jwtService;

    public JwtAuthenticationFilter(JwtService jwtService) {
        this.jwtService = jwtService;
    }

    @Override
    protected void doFilterInternal(HttpServletRequest request,
                                    HttpServletResponse response,
                                    FilterChain filterChain)
            throws ServletException, IOException {

        final String authHeader = request.getHeader("Authorization");
        final String jwt;

        // preskoci filter za /api/users/register, /api/users/login i OPTIONS zahtjeve
        if (request.getServletPath().contains("/api/users/register") ||
                request.getServletPath().contains("/api/users/login") ||
                request.getMethod().equals("OPTIONS")) {
            filterChain.doFilter(request, response);
            return;
        }

        // inace prvo provjeri ima li tokena
        if (authHeader == null || !authHeader.startsWith("Bearer ")) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Nedostaje JWT token");
            return;
        }

        // uzme token
        jwt = authHeader.substring(7);

        try {
            // provjera je li mu istekao rok trajanja
            if (jwtService.isTokenValid(jwt)) {
                String userId = jwtService.extractUserId(jwt);

                // Postavi autentikaciju u SecurityContext
                UsernamePasswordAuthenticationToken authToken =
                        new UsernamePasswordAuthenticationToken(
                                userId,
                                null,
                                null);
                authToken.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
                SecurityContextHolder.getContext().setAuthentication(authToken);
            } else {
                response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Nevažeći JWT token");
                return;
            }
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Nevažeći JWT token");
            return;
        }

        filterChain.doFilter(request, response);
    }
}